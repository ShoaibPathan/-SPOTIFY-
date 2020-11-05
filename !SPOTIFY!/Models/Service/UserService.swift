
import Foundation

class UserService {
    static let shared = UserService()

    let currentUser = User()
    
    private init(){}
    
    func favoriteSong(song: Song) {
        if !isFavorite(song: song){
       
            currentUser.favoritedSongs.append(song.title)
           }
    }
    
    func removeFavoriteSong(song: Song) {
        if let index = currentUser.favoritedSongs.firstIndex(of: song.title) {
            currentUser.favoritedSongs.remove(at: index)
          
        }
    }
    
    func isFavorite(song: Song) -> Bool {
        return currentUser.favoritedSongs.contains(song.title)
    }
    
    
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
