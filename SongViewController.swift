
import Foundation
import UIKit

class SongViewController: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func songSliderChanged(_ sender: UISlider) {
    }
    
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
    }
    @IBAction func dropdownArrowPressed(_ sender: UIButton) {
    }
    
}
