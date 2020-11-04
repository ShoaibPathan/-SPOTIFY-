import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var categories: [Category]!
    
    
    //Set the status bar icons to white so it shows up on the black background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        //Linked the view controller as the collection view's data source in main.storyboard
        tableView.dataSource = self
    
        categories = CategoryService.shared.categories
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let albumViewController = segue.destination as? AlbumViewController, let album = sender as? Album {
            if segue.identifier == "goToAlbum" {
                
                albumViewController.album = album 
    }

}


}
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[collectionView.tag]
        let selectedAlbum = category.albums[indexPath.row]
        performSegue(withIdentifier: "goToAlbum", sender: selectedAlbum)
        
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        let category = categories[indexPath.row]
        cell.updateCategoryCell(with: category, index: indexPath.row)
        return cell
    }
    
    
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //The number of items to display in the collection varies depending on the particular CATEGORY the section is in. That is why the category cell method assigns the collection view's TAG (aka POSITION)  property equal to the POSITION of the table view cell
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        //the collection view should return as many albums as there are in a given category section
        return category.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        // Copy and pasted "category index" and  "category" properties from the numberOfItemsInSection method above in order to get the CATEGORY position because the album cell will display different content based on the category its under
        let categoryIndex = collectionView.tag
        let category = categories[categoryIndex]
        //Use the indexpath.row position to retrieve the correct album cell for a given category
        let album = category.albums[indexPath.row]
        cell.updateAlbumCell(with: album)
        return cell
    }
    
    
}

