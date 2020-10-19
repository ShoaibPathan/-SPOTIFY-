
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
    }
    @IBAction func dropdownArrowPressed(_ sender: UIButton) {
    }
    
}
