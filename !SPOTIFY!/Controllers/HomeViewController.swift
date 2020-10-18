import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    
    var categories: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        categories = CategoryService.shared.categories
   
    }


}



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        let category = categories[indexPath.row]
        cell.updateCategoryCell(with: category, indexPath: indexPath.row)
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}

