
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
        
        //Use a temporary value for album property for data seeding purposes
        
        album = CategoryService.shared.categories.first!.albums.randomElement()
        songs = album.songs
        
        albumImage.image = UIImage(named: album.image)
        albumTitleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers by \(album.artist)"
        
        
        
   //Change button appearance
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 1.0
        followButton.layer.borderColor = UIColor.white.cgColor
        
        
        tableView.dataSource = self
    }
    

    @IBAction func followButtonPressed(_ sender: UIButton) {
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
