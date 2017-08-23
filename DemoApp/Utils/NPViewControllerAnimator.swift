import UIKit

class NPViewControllerAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // -- get fromvc,topvc
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        
        if isPresenting{
            containerView.addSubview(toView!)
        }
        
        let topVC = isPresenting ? toVC : fromVC
        let topPresentedView = topVC?.view
        
        // -- topPresented is on screen, topDismiss is off screen
        let topPresentedFrame = transitionContext.finalFrame(for: topVC!)
        var topDismissedFrame = topPresentedFrame
        topDismissedFrame.origin.y += topDismissedFrame.size.height
        
        // -- topInitial
        let topInitialFrame = isPresenting ? topDismissedFrame : topPresentedFrame
        let topFinalFrame = isPresenting ? topPresentedFrame : topDismissedFrame
        
        topPresentedView?.frame = topInitialFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
            topPresentedView?.frame = topFinalFrame
        }){ finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

