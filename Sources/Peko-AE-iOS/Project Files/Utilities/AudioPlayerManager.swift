//
//  AudioPlayerManager.swift
//  Peko
//
//  Created by Hardik Makwana on 27/09/24.
//

import UIKit
import AVFoundation

enum AudioFile : String{
    
    case IncomingCall = "incoming_call"
    case Notification = "notification"
//    case Regular = "Roboto-Regular"
//    case Medium = "Roboto-Medium"
//    case SemiBold = "Inter-SemiBold"
//    case Bold = "Roboto-Bold"
//    case ExtraBold = "Inter-ExtraBold"
//    
   
}

class AudioPlayerManager: NSObject {

    var player: AVAudioPlayer?

    override init() {
        super.init()
     //   self.configureAudioSession()
    }

    func configureAudioSession(){
        // Retrieve the audio session.
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        // set options to allow bluetooth device
        let options: AVAudioSession.CategoryOptions = .allowBluetooth
    //    var configError: Error?
        do {
            // Set the audio session category.
            try audioSession.setCategory(.playAndRecord, options: options)
            try AVAudioSession.sharedInstance().setActive(true)

            print("configureAudioSession successfully")
        } catch {
            print("configureAudioSession failed")
         //   configError = error
        }
     //   return configError
    }
    
// MARK: -
    func playSound(file:AudioFile) {
        
        guard let url = Bundle.main.url(forResource: "notification", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        /*
     //   let path = Bundle.main.path(forResource: "note\(buttonTag)", ofType : "wav")!
           
    //    guard let soundFileURL = Bundle.main.url(
      //      forResource: file.rawValue, withExtension: "mp4"
        
        guard let soundFileURL = Bundle.main.path(forResource: "incoming_call", ofType : "mp4") else {
            print("Not found")
            return
        }
        let url = URL(fileURLWithPath: soundFileURL)
         
//        guard let path = Bundle.main.path(forResource: file.rawValue, ofType:"mp3") else {
//            return }
//        let url = URL(fileURLWithPath: path)

        do {
//            try AVAudioSession.sharedInstance().setCategory(
//                AVAudioSession.Category.playback
//            )
//            
          
            player = try AVAudioPlayer(contentsOf: url)
            player!.numberOfLoops = -1
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        */
    }
    func stopSound() {
        if player != nil {
            player?.stop()
        }
    }
}
