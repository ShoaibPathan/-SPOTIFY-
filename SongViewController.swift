
import Foundation
import UIKit
import AVFoundation
import UIImageColors


class SongViewController: UIViewController  {
 
    var album: Album!
    var currentSongIndex: Int!
    var albumPrimaryColor: CGColor!
    var userTouchedSlider = false


    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    

    
override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioService.shared.delegate = self
        
        //Temporary: Data Seeding:
        
        album = CategoryService.shared.categories.randomElement()!.albums.randomElement()

        currentSongIndex = 0
      
        songSlider.value = 0
        
        currentTimeLabel.text = "00:00"
    
        let songSelection = album.songs[currentSongIndex]
    
    if UserService.shared.isFavorite(song: songSelection ){
        favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
    } else {
        favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
    }

    
        playSelectedSong()
        
    //UI customizations:
        albumPrimaryColor = UIColor.blue.cgColor
        albumImageView.image = UIImage(named: "\(album.image)-lg")
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [albumPrimaryColor!, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        view.layer.insertSublayer(gradientLayer, at: 0)
        playPauseButton.layer.cornerRadius = playPauseButton.frame.size.width / 2.0
    


}
    //Create private class function to play the current selected song
    private func playSelectedSong() {
        let selectedSong = album.songs[currentSongIndex]
       
        albumTitleLabel.text = selectedSong.title
        artistLabel.text = selectedSong.artist
        AudioService.shared.play(song: selectedSong)
        
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let selectedSong = album.songs[currentSongIndex]
        if UserService.shared.isFavorite(song: selectedSong){
            UserService.shared.removeFavoriteSong(song: selectedSong)
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            UserService.shared.favoriteSong(song: selectedSong)
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        }
        
    }
    
    
    @IBAction func songSliderChanged(_ sender: UISlider) {
        if sender.isContinuous {
            userTouchedSlider = true
            sender.isContinuous = false
        } else {
            userTouchedSlider = false
            AudioService.shared.play(atTime: Double(sender.value))
            sender.isContinuous = true
        }
    }
    
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
      //Because this button is used to either play or pause a song, create a property that tracks the current status of audio playback. If the UIButton 'sender' 's tag property equals zero then pause the song and set the image view to be the "play" image symbol
        //if button is pressed and changes from pause to play then the image view should be the "pause" pause symbol and Audio service should resume playing
        let TAG_PAUSE = 0
        let TAG_PLAY = 1
        
        if sender.tag == TAG_PAUSE {
            AudioService.shared.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            sender.tag = TAG_PLAY
            
        } else if sender.tag == TAG_PLAY{
            AudioService.shared.resume()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            sender.tag = TAG_PAUSE
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //Using the remainder operator to safeguard against an index out of range if user presses the next button and there are no more songs in the album. If the current song index + 1 reaches a point where the remainder is 0 then the current song index will be 0 and will halt
        currentSongIndex = (currentSongIndex + 1) % album.songs.count
        playSelectedSong()
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        //Swift Foundation's .max(_:, _:) function compares and returns the greater of two values. To avoid a user pressing previous button when they are already on the first song (to avoid an app crash due to index out of range) then as long as the current song index is subtracted by 1 when this button is tapped then if user tries to go to previous song when there is none, they will be setting the value to -1 and they won't be able to do that because the max function set the value 0 to be the greatest in the event that any number is less than 0
        currentSongIndex = max(0, currentSongIndex - 1)
        playSelectedSong()
    }
    
    
    @IBAction func dropdownArrowPressed(_ sender: UIButton) {
    }
    
}
extension SongViewController: AudioServiceDelegate {
    func songIsPlaying(currentTime: Double, duration: Double) {
        //Set the slider's max value equal to the length of whatever song is currently playing
        songSlider.maximumValue = Float(duration)
        
        //To fix the "flickering effect" of the timer, the delegate method should only update the time labels if the user is not interacting with the slider.
        if !userTouchedSlider {
        songSlider.value = Float(currentTime)
        }
        //Update the current time and the duration UILabels) using the formatted string from the function below:
        currentTimeLabel.text = convertTimeToString(time: currentTime)
        durationLabel.text = convertTimeToString(time: duration)
        
    }
    
    func convertTimeToString(time: Double) -> String {
        let seconds = Int(time) % 60
        let minutes = (Int(time) / 60) % 60
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
}
