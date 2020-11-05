
import Foundation
import UIKit
import UIImageColors

class AlbumViewController: UIViewController {
  
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var albumPrimaryColor: CGColor!
    var album: Album!
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
      
        albumImage.image?.getColors({ colors in
            self.albumPrimaryColor = colors!.primary.withAlphaComponent(0.8).cgColor
            self.updateBackground(with: self.albumPrimaryColor)
        })
        updateUI()
       
        setFollowButton()
    }
    

    @IBAction func followButtonPressed(_ sender: UIButton) {
        
        if UserService.shared.isFollowingAlbum(album: album) {
            UserService.shared.unfollowAlbum(album: album)
            followButton.setTitle("Follow", for: .normal)
          followButton.layer.borderColor = UIColor.white.cgColor
        }   else {
            UserService.shared.followAlbum(album: album)
            followButton.setTitle("Following", for: .normal)
           followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
        }
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songViewController = segue.destination as? SongViewController, let selectedSongIndex = sender as? Int {
            if segue.identifier == "SongSegue" {
                songViewController.album = album
                songViewController.selectedSongIndex = selectedSongIndex
                songViewController.albumPrimaryColor = albumPrimaryColor
            }
        }
    }
    @IBAction func shuffleButtonPressed(_ sender: UIButton) {
        let randomSongIndex = Int(arc4random_uniform(UInt32(album.songs.count)))
        performSegue(withIdentifier: "SongSegue", sender: randomSongIndex)
    }
}
//MARK: - Table View Data Source Methods:

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = album.songs[indexPath.row]
        cell.updateSongCell(with: song)
        return cell
    }
}
//MARK: - Table View Delegate Methods:

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SongSegue", sender: indexPath.row)
    }
}

//MARK: - View Controller UI Appearance Extension to declutter viewDidLoad block:

extension AlbumViewController {
    func updateUI() {
        albumImage.image = UIImage(named: album.image)
        albumTitleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 2.0
        followButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func updateBackground(with color: CGColor){
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [backgroundColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
  
        let gradientChangedAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangedAnimation.duration = 0.5
        gradientChangedAnimation.toValue = [color, backgroundColor]
        gradientChangedAnimation.isRemovedOnCompletion = false
        gradientChangedAnimation.fillMode = .forwards
        gradientLayer.add(gradientChangedAnimation, forKey: "colorChange")
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func setFollowButton() {
    if UserService.shared.isFollowingAlbum(album: album){
        followButton.setTitle("Following", for: .normal)
        followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
    } else {
        followButton.setTitle("Follow", for: .normal)
        followButton.layer.borderColor = UIColor.white.cgColor
    }
    }
}
