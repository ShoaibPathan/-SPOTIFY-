
import Foundation
import AVFoundation

class AudioService {
    static let shared = AudioService()
    
    var audioPlayer: AVAudioPlayer!
    
    let appSongs = ["song-0", "song-1", "song-2"]
    
    private init(){
//        let songsURL = Bundle.main.url(forResource: , withExtension: "mp3")
    }
    
    func play(song: Song){
        let randomSong = appSongs.randomElement()!
        let songURL = Bundle.main.url(forResource: randomSong, withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: songURL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    func pause(){
        
    }
    
    func resume(){
      
    }
}
