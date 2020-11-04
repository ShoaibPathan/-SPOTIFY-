
import Foundation
import RealmSwift

class UserData: Object {

    @objc dynamic var userFollows: Bool = false 

    @objc dynamic var userLikesSong: String = ""
}
