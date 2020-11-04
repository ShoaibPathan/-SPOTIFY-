
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
    var currentUser = User()
    let defaults = UserDefaults.standard

    var usersAlbums = UserService.shared.getUsersAlbums()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    
    
   

//    followButton.currentTitle = defaults.string(forKey: <#T##String#>)
    
        tableView.dataSource = self
        tableView.delegate = self

       
        
              
        albumImage.image = UIImage(named: album.image)
        albumTitleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
        
        
        //Implement background gradient effect
        albumImage.image?.getColors({ colors in
            self.albumPrimaryColor = colors!.primary.withAlphaComponent(0.8).cgColor
            self.updateBackground(with: self.albumPrimaryColor)
        })

        
   //Change button appearance
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 2.0
        followButton.layer.borderColor = UIColor.white.cgColor
        
    
    if usersAlbums.contains(album.name) {
        followButton.setTitle("Following", for: .normal)
        followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
        
    } else {
    
        followButton.setTitle("Follow", for: .normal)
        followButton.layer.borderColor = UIColor.white.cgColor
    }
    
    
    }
    
    func updateBackground(with color: CGColor){
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [backgroundColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        //Gradient layer animation
        let gradientChangedAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangedAnimation.duration = 0.5
        gradientChangedAnimation.toValue = [color, backgroundColor]
        gradientChangedAnimation.isRemovedOnCompletion = false
        gradientChangedAnimation.fillMode = .forwards
        gradientLayer.add(gradientChangedAnimation, forKey: "colorChange")
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
        

    @IBAction func followButtonPressed(_ sender: UIButton) {
       
        if followButton.isSelected {
            if usersAlbums.contains(album.name) {
                
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
            
        } else {
        
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }
            descriptionLabel.text = "\(album.followers) followers by \(album.artist)" }
    }
//      //Check if the user is already following the album:
//        if UserService.shared.isFollowingAlbum(album: album) {
//            defaults.set(true, forKey: "Following")
//        //if YES and they tap the button then UNFOLLOW the album and change the button back to "Follow" with a white border:
//            UserService.shared.unfollowAlbum(album: album)
//            followButton.setTitle("Follow", for: .normal)
//            followButton.layer.borderColor = UIColor.white.cgColor
//
//        }
//        else {
//        //if NO, and they tap the button then FOLLOW the album:
//            defaults.set(false, forKey: "NotFollowing")
//            UserService.shared.followAlbum(album: album)
//            followButton.setTitle("Following", for: .normal)
//            followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
//
//        }
       
//MARK: -  STORYBOARD SEGUE TO SELECTED ALBUM'S SONG LIST
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

//MARK: -  UITableView Data Source & Delegate Methods
extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.songs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = album.songs[indexPath.row]
        cell.updateSongCell(with: song)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SongSegue", sender: indexPath.row)
        
    }
}
