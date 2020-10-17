
import Foundation

class CategoryService {
    static let shared = CategoryService()
    
    let categories: [Category]
    
    private init(){
        let categoriesURL = Bundle.main.url(forResource: "categories", withExtension: "json")!
        let data = try! Data(contentsOf: categoriesURL)
        let decoder = JSONDecoder()
        categories = try! decoder.decode([Category].self, from: data)
    }
    
    
    
}
