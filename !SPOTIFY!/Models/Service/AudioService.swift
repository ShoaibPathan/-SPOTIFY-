
import Foundation
import AVFoundation

//MARK: - DELEGATE DESIGN PATTERN:
/*The AVAudio player is an object that tracks audio data and information. This makes the audio player a perfect candidate for being a DELEGATOR for the song view controller because the player possesses the ability to listen in and observe the song track duration time. The song view controller has two labels, a start/begin time label and an end time label that reflects and upates continuously as a song is currently playing. The song track UISlider in the view controller when interacted with by the user should track this activity and to do so it needs to rely on the audio player's data information.
 */

protocol AudioServiceDelegate {
    // this method will track the song progress:
    func songIsPlaying(currentTime: Double, duration: Double)

}

class AudioService {
    static let shared = AudioService()
    
    //MARK: - Configure delegate property
    var delegate: AudioServiceDelegate?
    
   //The means by which the audio player will communicate with the song view controller is through use of an NSTimer object to track song progress:
    
    var timer: Timer?
    
    var audioPlayer: AVAudioPlayer!
    var songIsLiked = false
    let appSongs = ["song-0", "song-1", "song-2"]
    
    private init(){ }
    
    
    //MARK: -  START THE TIMER WHEN THE PLAY METHOD IS INVOKED:
    
    func play(song: Song){
        let randomSong = appSongs.randomElement()!
        let songURL = Bundle.main.url(forResource: randomSong, withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: songURL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        startTimer()
        
    }
    
    //MARK: - STOP THE TIMER IF PAUSE IS PRESSED
    func pause(){
        audioPlayer.pause()
        stopTimer()
    }
 //MARK: - CALL FOR TIMER TO START AGAIN IF SONG IS UNPAUSED
    func resume(){
        audioPlayer.play()
        startTimer()
    }
    
 //MARK: -  Create a function that controls functionality of the song track time slider
    func play(atTime time: Double) {
        audioPlayer.currentTime = time
        
    }

    
    //MARK: - Create two new methods for the timer's functionality that will be passed to the song view controller as delegate
    
    //1. Start timer: This timer will execute every second in order to track song progress. The start timer code block is storing the current time and the duration values in order to transfer/communicate these values with its delegate(the song view controller)
    
    private func startTimer(){
     timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.delegate?.songIsPlaying(currentTime: self.audioPlayer.currentTime, duration: self.audioPlayer.duration)
        }
    }
    
    //2. Stop timer: To stop the timer, use NSTimer's .invalidate() method and set the timer's value to NIL
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}
