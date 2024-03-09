//
//  TemplateDataManager.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation
import CoreData

class TemplateDataManager: ObservableObject {
    @Published var templates: [TemplateModel] = []
    @Published var selectedTemplate: TemplateModel? {
        didSet {
            spinReset()
        }
    }
    @Published var selectedOption: OptionModel?
    @Published var timeInterval: TimeInterval = 0.1
    
    private let dataCenter = TemplateDataCenter.shared
    private let context: NSManagedObjectContext
    private var colorThemeProvider = ColorThemeProvider()
    private let timer = TimerManager()
    private let userDefaults = UserDefaultsManager.shared
    private let soundPlayer = SoundPlayer()
    private let haptic = Haptic()
    
    init() {
        context = dataCenter.context
        launch()
    }
    
    private func launch() {
        if userDefaults.getHasLaunchedValue() == false {
            addDefaultTemplate()
            userDefaults.updateHasLaunchedValue(with: true)
        } else {
            fetchTemplates()
            fetchSelectedTemplate()
        }
    }
    
    private func addDefaultTemplate() {
        let template = Template(
            question: "Pick a color",
            options: ColorTheme.allCases.map { Option(content: $0.rawValue) },
            order: 0
        )
        add(template)
    }
    
    private func fetchTemplates() {
        let request = TemplateModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            templates = try context.fetch(request)
        } catch {
            print("Unable to fetch the request: \(error)")
        }
    }
    
    private func fetchSelectedTemplate() {
        selectedTemplate = templates.first(where: { $0.id == userDefaults.getSelectedTemplateID() })
    }
    
    func updateSelectedTemplate(with id: String) {
        userDefaults.updateSelectedTemplateID(with: id)
        fetchSelectedTemplate()
    }
    
    func add(_ template: Template) {
        let templateModel = TemplateModel(context: context)
        templateModel.creationDate = .now
        templateModel.order = template.order
        update(templateModel, with: template)
    }
    
    func update(_ templateID: String, with template: Template) {
        let templateModel = templates.first(where: { $0.id == templateID })
        templateModel?.options = nil
        if let templateModel = templateModel {
            update(templateModel, with: template)
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            context.delete(templates[index])
        }
        dataCenter.save()
        fetchTemplates()
        if !templates.isEmpty {
            userDefaults.updateSelectedTemplateID(with: templates[0].id!)
            selectedTemplate = templates[0]
        } else {
            userDefaults.updateSelectedTemplateID()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        templates.move(fromOffsets: source, toOffset: destination)
        for (index, template) in templates.enumerated() {
            template.order = Int16(index)
        }
        dataCenter.save()
    }
    
    private func update(_ templateModel: TemplateModel, with template: Template) {
        colorThemeProvider.allColorThemes = ColorTheme.allCases.shuffled()
        templateModel.question = template.question.capitalizeFirstLetter()
        templateModel.id = template.id
        let optionSet = convertToOptionModelSet(from: template.options)
        templateModel.addToOptions(optionSet)
        userDefaults.updateSelectedTemplateID(with: template.id)
        dataCenter.save()
        fetchTemplates()
        fetchSelectedTemplate()
    }
    
    private func convertToOptionModelSet(from optionArray: [Option]) -> NSOrderedSet {
        return NSOrderedSet(array: optionArray.map { option in
            let optionModel = OptionModel(context: context)
            optionModel.id = option.id
            optionModel.content = option.content
            optionModel.weight = option.weight
            optionModel.themeString = colorThemeProvider.getColorTheme().rawValue
            return optionModel
        })
    }
    
    func validate(_ template: Template, mode: TemplateEditorMode = .editing) throws -> Bool {
        if template.question.isEmpty {
            throw TemplateError.emptyQuestion
        }
        
        if mode == .adding, let id = templates.first(where: { $0.question?.lowercased() == template.question.lowercased() })?.id {
            updateSelectedTemplate(with: id)
            throw TemplateError.duplicateQuestion
        }
        var uniqueContentSet = Set<String>()
        for option in template.options {
            if option.content.isEmpty {
                throw TemplateError.emptyOption
            }
            if !uniqueContentSet.insert(option.content).inserted {
                throw TemplateError.duplicateOption
            }
        }
        if template.options.count < 2 {
            throw TemplateError.insufficientOptions
        }
        return true
    }
    
    func spin(_ template: TemplateModel) {
        spinReset()
        guard let options = template.options?.array as? [OptionModel] else { return }
        var elapsed: TimeInterval = 0
        timer.setupTimer(repeating: timeInterval) { [weak self] in
            guard let self = self else { return }
            if elapsed < 2 {
                elapsed += timeInterval
                selectedOption = options.randomElement()
                soundPlayer.play()
                haptic.triggerImpactHaptics()
            } else {
                timer.cancel()
                elapsed = 0
                timer.setupTimer { [weak self] in
                    guard let self = self else { return }
                    if elapsed < 4 {
                        elapsed += timeInterval
                        selectedOption = options.randomElement()
                        timer.schedule(deadline: .now() + timeInterval)
                        timeInterval += 0.1
                        soundPlayer.play()
                        haptic.triggerImpactHaptics()
                    } else {
                        timer.cancel()
                        selectedOption = selectRandomOption(options: options)
                        soundPlayer.play()
                        haptic.triggerImpactHaptics()
                    }
                }
            }
        }
    }
    
    func spinReset() {
        timer.reset()
        selectedOption = nil
        timeInterval = 0.1
    }
    
    private func selectRandomOption(options: [OptionModel]) -> OptionModel? {
        let totalWeight = options.reduce(0) { $0 + $1.weight }
        guard totalWeight > 0 else { return nil }
        let randomNumber = Int16.random(in: 0..<totalWeight)
        var currentWeight: Int16 = 0
        for option in options {
            currentWeight += option.weight
            if randomNumber < currentWeight {
                return option
            }
        }
        return nil
    }
    
    func navigateOptionsBySwipe(translationWidth: Double) {
        let selectedIndex = templates.firstIndex(where: { $0.id == selectedTemplate?.id }) ?? 0
        if translationWidth < 50 && selectedIndex < templates.count - 1 {
            selectedTemplate = templates[selectedIndex + 1]
        } else if translationWidth > 50 && selectedIndex > 0 {
            selectedTemplate = templates[selectedIndex - 1]
        }
        userDefaults.updateSelectedTemplateID(with: selectedTemplate?.id)
    }
}
