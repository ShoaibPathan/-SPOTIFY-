
import Foundation

class AlbumService {
    static let shared = AlbumService()
   
    private init(){}
    
        func getAlbum(from category: Category)-> [Album] {
            let album = category.albums
            return album
        }
    }
   
