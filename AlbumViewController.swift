
import Foundation
import UIKit

class AlbumViewController: UIViewController {
  
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var songs: [Song]!
    var album: Album!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        //Use a temporary value for album property for data seeding purposes
        
        album = CategoryService.shared.categories.first!.albums.randomElement()
        songs = album.songs
        
        //Implement background gradient effect
        let primaryColor = #colorLiteral(red: 0.5273327231, green: 0.1593059003, blue: 0.4471139908, alpha: 1).cgColor
        updateBackground(with: primaryColor)
        
        albumImage.image = UIImage(named: album.image)
        albumTitleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
        
        if UserService.shared.isFollowingAlbum(album: album){
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }
        
   //Change button appearance
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 2.0
        followButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func updateBackground(with color: CGColor){
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [color, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func followButtonPressed(_ sender: UIButton) {
      //Check if the user is already following the album:
        if UserService.shared.isFollowingAlbum(album: album) {
        //if YES and they tap the button then UNFOLLOW the album and change the button back to "Follow" with a white border:
            UserService.shared.unfollowAlbum(album: album)
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
        }
        else {
        //if NO, and they tap the button then FOLLOW the album:
            UserService.shared.followAlbum(album: album)
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = #colorLiteral(red: 0.1627579331, green: 0.6996970177, blue: 0.2955926955, alpha: 1).cgColor
        }
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
    }
    
    @IBAction func shuffleButtonPressed(_ sender: UIButton) {
    }
    
    
    
}
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        let song = songs[indexPath.row]
        cell.updateSongCell(with: song)
        return cell
    }
    
    
}
