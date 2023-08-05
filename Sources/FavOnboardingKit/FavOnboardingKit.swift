import UIKit

public protocol FavOnboardingKitDelegateProtocol: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}

public class FavOnboardingKit {

    private weak var delegate: FavOnboardingKitDelegateProtocol?

    private let slides: [Slide]
    private let tintColor: UIColor
    private var roorVC: UIViewController?

    private lazy var onboardingViewController: OnboardingViewController = {
        let controller =  OnboardingViewController(slides: slides, tintColor: tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        return controller
    }()

    public init(slides: [Slide], tintColor: UIColor, delegate: FavOnboardingKitDelegateProtocol?) {
        self.delegate = delegate
        self.slides = slides
        self.tintColor = tintColor
        configOnboardingViewControllerClosures()
    }

    public func launchOnboarding(rootVC: UIViewController) {
        self.roorVC = rootVC
        rootVC.present(onboardingViewController, animated: true)
    }

    public func dismissOnboarding() {
        onboardingViewController.stopAnimation()
        if roorVC?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }

    private func configOnboardingViewControllerClosures() {
        onboardingViewController.nextButtonDidTap = { [weak self] index in
            self?.delegate?.nextButtonDidTap(atIndex: index)
        }

        onboardingViewController.getStartedButtonDidTap = { [weak self] in
            self?.delegate?.getStartedButtonDidTap()
        }
    }
}
