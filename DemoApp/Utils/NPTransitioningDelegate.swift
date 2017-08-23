import UIKit

class NPTransitioningDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    weak var interactionController: UIPercentDrivenInteractiveTransition?
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        
        return NPPresentationController(presentedViewController: presented,
                                        presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController)-> UIViewControllerAnimatedTransitioning? {
        let animator = NPViewControllerAnimator()
        animator.isPresenting = true
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NPViewControllerAnimator()
        animator.isPresenting = false
        
        return animator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}

