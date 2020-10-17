import UIKit

class HomeViewController: UIViewController {

    var categories: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        categories = CategoryService.shared.categories
    }


}

