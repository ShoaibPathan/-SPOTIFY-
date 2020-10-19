
import Foundation

class UserService {
    static let shared = UserService()
    
    private let currentUser = User()
    
    private init(){}
    
    
    func followAlbum(album: Album) {
        //evaluate whether user is already following an album or not before adding it to their followed albums array
        if !isFollowingAlbum(album: album) {
        currentUser.followingAlbums.append(album.name)
        album.followers += 1
    }
    }
    
    func unfollowAlbum(album: Album) {
        if let index = currentUser.followingAlbums.firstIndex(of: album.name){
            currentUser.followingAlbums.remove(at: index)
            album.followers -= 1
        }
        
    }
    
    
    func isFollowingAlbum(album: Album) -> Bool {
        return currentUser.followingAlbums.contains(album.name)
    }
}
