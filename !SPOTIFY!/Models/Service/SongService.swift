
import Foundation

class SongService {
    static let shared = SongService()
    
    var song: Song!
    private init(){}
    
    func getSong(song: Song) {
        let song = AudioService.shared.appSongs.randomElement()
    }

    }
    
    
