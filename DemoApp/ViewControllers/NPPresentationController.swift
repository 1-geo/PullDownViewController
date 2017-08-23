import UIKit

class NPPresentationController: UIPresentationController {
    let dimmingView = UIView()
    
    init(presentedViewController: UIViewController!, presenting presentingViewController: UIViewController??) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController!)
        
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    }
    
    override var presentationStyle: UIModalPresentationStyle{
        return .overFullScreen
    }
    
    override var shouldPresentInFullscreen: Bool{
        return true
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = (containerView?.bounds)!
        dimmingView.alpha = 0.0
        containerView?.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            context in
            self.dimmingView.alpha = 1.0
            
            self.presentedView?.layer.cornerRadius = 6
            self.presentedView?.layer.masksToBounds = true
            
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            context in
            self.dimmingView.alpha = 0.0
            
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed{
            self.dimmingView.removeFromSuperview()
        }else{
            self.dimmingView.alpha = 1.0
            
            self.presentedView?.layer.cornerRadius = 6
            self.presentedView?.layer.masksToBounds = true
            
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }
    
    // calculate prestend VCs view frame
    override var frameOfPresentedViewInContainerView : CGRect {
        let boundHeight = containerView?.bounds.height
        let boundWidth = containerView?.bounds.width
        
        //let bound = CGRect(x: 0, y: 45, width: boundWidth!, height: boundHeight! - 45)
        let bound = CGRect(x: 0, y: 0, width: boundWidth!, height: boundHeight!)
        return bound
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = (containerView?.bounds)!
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
