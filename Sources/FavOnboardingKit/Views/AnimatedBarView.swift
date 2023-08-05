import Combine
import UIKit

final class AnimatedBarView: UIView {
    enum State {
        case clear
        case animating
        case filled
    }

    // MARK: Properties
    private let barColor: UIColor

    @Published private var state: State = .clear
    private var subscribers = Set<AnyCancellable>()
    private var animator: UIViewPropertyAnimator?

    private lazy var backgroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()

    private lazy var foregroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0
        view.clipsToBounds = true
        return view
    }()

    // MARK: LifeCycle
    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        setupViews()
        observe()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Private Methods
    private func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 3.0,
                                          curve: .easeInOut,
                                          animations: {
            self.foregroundBarView.transform = .identity
        })
    }

    private func observe() {
        $state.sink { [unowned self] state in
            switch state {
            case .clear:
                setupAnimator()
                foregroundBarView.alpha = 0.0
                animator?.stopAnimation(false)
            case .animating:
                foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                foregroundBarView.transform = .init(translationX:  -frame.size.width, y: 0)
                foregroundBarView.alpha = 1.0
                animator?.startAnimation()
            case .filled:
                animator?.stopAnimation(true)
                foregroundBarView.transform = .identity
            }
        }.store(in: &subscribers)
    }

    func startAnimating() {
        state = .animating
    }

    func resetAnimating() {
        state = .clear
    }

    func completeAnimation() {
        state = .filled
    }

    // MARK: Selectors
}

// MARK: View Configuration
extension AnimatedBarView: ViewConfiguration {
    func configViews() {}

    func buildViews() {
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
    }

    func setupConstraints() {
        backgroundBarView.setAnchorsEqual(to: self)
        foregroundBarView.setAnchorsEqual(to: backgroundBarView)
    }
}
