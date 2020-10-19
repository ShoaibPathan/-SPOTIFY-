
import Foundation
import UIKit
import AVFoundation
import UIImageColors


class SongViewController: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    var album: Album!
    var currentSongIndex: Int!
    var albumPrimaryColor: CGColor!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Temporary: Data Seeding
        
        album = CategoryService.shared.categories.randomElement()!.albums.randomElement()
        albumPrimaryColor = UIColor.blue.cgColor
        albumImageView.image = UIImage(named: "\(album.image)-lg")
        songSlider.value = 0
        startTimeLabel.text = "00:00"
        
        playPauseButton.layer.cornerRadius = playPauseButton.frame.size.width / 2
        
        
        
        
        //Gradient background
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [albumPrimaryColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    
        
    }
    //Create private class function to play the current selected song
    private func playSelectedSong() {
        let selectedSong = album.songs[currentSongIndex]
        AudioService.shared.play(song: selectedSong)
        albumTitleLabel.text = selectedSong.title
        artistLabel.text = selectedSong.artist
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func songSliderChanged(_ sender: UISlider) {
    }
    
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        AudioService.shared.pause()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        //Swift Foundation's .max(_:, _:) function compares and returns the greater of two values. To avoid a user pressing previous button when they are already on the first song (to avoid an app crash due to index out of range) then as long as the current song index is subtracted by 1 when this button is tapped then if user tries to go to previous song when there is none, they will be setting the value to -1 and they won't be able to do that because the max function set the value 0 to be the greatest in the event that any number is less than 0 
        currentSongIndex = max(0, currentSongIndex - 1)
        playSelectedSong()
    }
    
    
    
    @IBAction func dropdownArrowPressed(_ sender: UIButton) {
    }
    
}
