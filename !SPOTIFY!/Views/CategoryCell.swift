
import UIKit

class CategoryCell: UITableViewCell {

  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func updateCategoryCell(with category: Category, indexPath: Int){
        titleLabel.text = category.title
        subtitleLabel.text = category.subtitle
        
        //will address the indexpath property later on...
    }
    
}
