
//  SoundManager.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 05/02/24.


import Foundation
import AVKit

class SoundManager {
    static let playerInstance = SoundManager()
    
    var effectsPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?

    
    enum SoundOptions: String {
            case correctIngredient = "blenderpour"
            case wrongIngredient = "wrong"
            case blender = "blending"
            case milk = "milkdrop"
            case background = "brazilcafe"
    }
    
    func playSound(sound: SoundOptions) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
                
        do {
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            effectsPlayer = try AVAudioPlayer(contentsOf: url)
            effectsPlayer?.play()
        } catch {
            print("error")
        }
    }
    
    func playBackground() {
        guard let url = Bundle.main.url(forResource: SoundOptions.background.rawValue, withExtension: ".mp3") else { return }
                
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.1
            backgroundPlayer?.play()
        } catch {
            print("error")
        }
    }

}
