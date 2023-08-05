import UIKit

class OnboardingViewController: UIViewController {

    private let slides: [Slide]
    private let tintColor: UIColor

    var nextButtonDidTap: ((Int) -> Void)?
    var getStartedButtonDidTap: (() -> Void)?

    // MARK: Layout Properties
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var transitionView: TransitionView = TransitionView(slides: slides, barColor: tintColor)

    private lazy var buttonContainerView: ButtonContainerView =  {
        let button = ButtonContainerView(tintColor: tintColor)
        button.getStartedButtonDidTap = getStartedButtonDidTap
        return button
    }()

    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
        configureClosures()
        setupGesture()
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }

    private func configureClosures() {
        buttonContainerView.nextButtonDidTap = { [weak self] in
            guard let self = self else { return }
            self.nextButtonDidTap?(self.transitionView.index)
            self.transitionView.handleTap(direction: .right)
        }

        buttonContainerView.getStartedButtonDidTap = { [weak self] in
            self?.getStartedButtonDidTap?()
        }
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        transitionView.addGestureRecognizer(tapGesture)
    }

    @objc private func viewDidTap(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: view)
        let midPoint = view.frame.size.width / 2
        if point.x > midPoint {
            transitionView.handleTap(direction: .right)
        } else {
            transitionView.handleTap(direction: .left)
        }
    }

    func stopAnimation() {
        transitionView.stop()
    }
}

// MARK: ViewConfiguration
extension OnboardingViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
        transitionView.backgroundColor = .blue
    }

    func buildViews() {
        view.addSubview(contentStackView)
        [transitionView, buttonContainerView].forEach { contentStackView.addArrangedSubview($0) }
    }

    func setupConstraints() {
        contentStackView.setAnchorsEqual(to: view, safe: true)
        buttonContainerView.size(height: 120)
    }
}
