import UIKit

class NPMusicController: UIViewController{
    // pan start location
    var panLocationStart: CGFloat?
    
    // interaction controller
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    // must hold reference to it, else this will be cleaned in memory
    let npTransitioningDelegate = NPTransitioningDelegate()
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        // setup modal transition
        transitioningDelegate = npTransitioningDelegate
        modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "222222")
        
        // setup pan gesture
        let panDown = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        panDown.maximumNumberOfTouches = 1
        panDown.delegate = self
        view.addGestureRecognizer(panDown)
        
        // dismiss button
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Dismiss", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        view.addSubview(btn)
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        btn.addTarget(self, action: #selector(NPMusicController.handleDismissedPressed), for: .touchUpInside)
    }
    
    @objc func handleDismissedPressed(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

//*****************************************************************
// MARK: - Pan Gesture/ InteractionTransition Logic
//*****************************************************************
extension NPMusicController: UIGestureRecognizerDelegate{
    
    // only recognize pan down gesture
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = pan.translation(in: pan.view)
            let angle = atan2(translation.y, translation.x)
            return abs(angle - .pi / 2.0) < (.pi / 8.0)
        }
        return false
    }
    
    // handle pan down gesture
    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        var location = gesture.translation(in: view.window)
        location = location.applying(view.transform.inverted())
        
        var velocity = gesture.velocity(in: view.window)
        velocity = velocity.applying(view.transform.inverted())
        
        if gesture.state == .began{
            interactionController = UIPercentDrivenInteractiveTransition()
            let transitiondelegate = transitioningDelegate as! NPTransitioningDelegate
            transitiondelegate.interactionController = interactionController
            
            panLocationStart = location.y
            dismiss(animated: true)
        }else if gesture.state == .changed{
            let animationRatio = (location.y - self.panLocationStart!) / self.view.bounds.height
            
            if animationRatio > 0.30{
                interactionController?.finish()
                interactionController = nil
            }
            
            self.interactionController?.update(animationRatio)
        }else if gesture.state == .cancelled || gesture.state == .ended{
            if velocity.y > 400{
                interactionController?.finish()
            }else{
                interactionController?.cancel()
            }
            
            interactionController = nil
        }
    }
}


