import UIKit

class BrowseController: ViewController{
    
    var npView: UIControl!
    var npHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Browse".uppercased()
        addNpBar()
    }
    
    // add np bar programatically.
    fileprivate func addNpBar(){
        npView = UIControl()
        npView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(npView)
        npView.backgroundColor = ColorPalette.tabcolor
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: npView)
        view.addConstraintWithFormat(format: "V:[v0]|", views: npView)
        npHeightConstraint = NSLayoutConstraint(item: npView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45)
        NSLayoutConstraint.activate([npHeightConstraint])
        
        npView.addTarget(self, action: #selector(BrowseController.presentNowPlayingViewController), for: .touchUpInside)
    }
    
    @objc func presentNowPlayingViewController(){
        present(NPMusicController(), animated: true)
    }
}

