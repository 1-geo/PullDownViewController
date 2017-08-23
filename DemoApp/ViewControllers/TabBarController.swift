import UIKit

class TabBarController:  UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize tab bar
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = ColorPalette.tabcolor
        
        // add in VCs
        let browseVC = NavigationController(rootViewController: BrowseController())
        browseVC.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named: "tab_icon_home")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "tab_icon_home_filled")?.withRenderingMode(.alwaysTemplate))
        
        viewControllers = [browseVC]
    }
}

