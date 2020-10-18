
import UIKit

class CategoryCell: UITableViewCell {

  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func updateCategoryCell(with category: Category, index: Int){
        titleLabel.text = category.title
        subtitleLabel.text = category.subtitle
        //Assign the collection view tag property equal to the table view cell's indexpath.row property
        collectionView.tag = index
        collectionView.reloadData()
        
    }
    
}
