
import Foundation
import AVFoundation


/*
 The AVAudio player is an object that tracks audio data and information. This makes the audio player a perfect candidate for being a DELEGATOR for the song view controller because the player possesses the ability to listen in and observe the song track duration time. The song view controller has two labels, a start/begin time label and an end time label that reflects and upates continuously as a song is currently playing. The song track UISlider in the view controller when interacted with by the user should track this activity and to do so it needs to rely on the audio player's data information.
 */

protocol AudioServiceDelegate {
    // this method will track the song progress:
    func songIsPlaying(currentTime: Double, duration: Double)
}

class AudioService {
    static let shared = AudioService()
    
    var delegate: AudioServiceDelegate?
   //The means by which the audio player will communicate with the song view controller is through use of an NSTimer object to track song progress
    
    var audioPlayer: AVAudioPlayer!
    var songIsLiked = false
    let appSongs = ["song-0", "song-1", "song-2"]
    
    private init(){ }
    
    func play(song: Song){
        let randomSong = appSongs.randomElement()!
        let songURL = Bundle.main.url(forResource: randomSong, withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: songURL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    // Create a function that controls functionality of the song track time slider
    func playSong(atTime time: Double) {
        audioPlayer.currentTime = time
        
    }
    
    func pause(){
        audioPlayer.pause()
    }
    
    func resume(){
        audioPlayer.play()
    }
    
    func songLiked() -> Bool {
        
        return songIsLiked
    }
    
}
