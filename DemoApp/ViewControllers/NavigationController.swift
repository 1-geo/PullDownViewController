import UIKit

class NavigationController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize navbar
        navigationBar.barTintColor = ColorPalette.navcolor
        navigationBar.shadowImage = UIImage()
        navigationBar.barStyle = .blackTranslucent
        navigationBar.tintColor = .white
        
        // customize font
        if let titleFont = Font.montSerratRegular(size: 16){
            navigationBar.titleTextAttributes = [.font : titleFont]
        }
    }
}

