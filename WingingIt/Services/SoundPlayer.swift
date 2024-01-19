//
//  SoundPlayer.swift
//  WingingIt
//
//  Created by CJ on 11/23/23.
//

import AVFoundation

final class SoundPlayer {
    private var player: AVAudioPlayer?

    init(fileName: String = "Du", fileExtension: String = "mp3") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            fatalError("Unable to find the sound file.")
        }
        configurePlayer(url: url)
    }
    
    private func configurePlayer(url: URL) {
        do {
            try player = AVAudioPlayer(contentsOf: url)
            player?.enableRate = true
            player?.rate = 5
            player?.volume = 5
            player?.prepareToPlay()
        } catch {
            fatalError("Unable to initialize AVAudioPlayer: \(error.localizedDescription)")
        }
    }

    func play() {
        player?.play()
    }

    func stop() {
        player?.stop()
    }
}
