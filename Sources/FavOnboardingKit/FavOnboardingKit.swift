import UIKit

public protocol FavOnboardingKitDelegateProtocol: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}

public class FavOnboardingKit {

    private weak var delegate: FavOnboardingKitDelegateProtocol?

    private let slides: [Slide]
    private let tintColor: UIColor
    private let themeFont: UIFont
    private var roorVC: UIViewController?

    private lazy var onboardingViewController: OnboardingViewController = {
        let controller =  OnboardingViewController(slides: slides, tintColor: tintColor, themeFont: themeFont)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        return controller
    }()

    public init(slides: [Slide], tintColor: UIColor, delegate: FavOnboardingKitDelegateProtocol?, themeFont: UIFont = UIFont(name: "ArialRoundedMTBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)) {
        self.delegate = delegate
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
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
