import UIKit

class OnboardingViewController: UIViewController {

    private let slides: [Slide]
    private let tintColor: UIColor

    // MARK: Layout Properties
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var transitionView: UIView = TransitionView()

    private lazy var buttonContainerView: UIView = ButtonContainerView()

    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)

        configViews()
        buildViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configViews() {
        view.backgroundColor = .red
        transitionView.backgroundColor = .blue
        buttonContainerView.backgroundColor = .green
    }

    private func buildViews() {
        view.addSubview(contentStackView)
        [transitionView, buttonContainerView].forEach { contentStackView.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        buttonContainerView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
