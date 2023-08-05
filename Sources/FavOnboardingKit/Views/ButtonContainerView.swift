import UIKit

final class ButtonContainerView: UIView {

    var nextButtonDidTap: (() -> Void)?
    var getStartedButtonDidTap: (() -> Void)?

    private let viewTintColor: UIColor

    // MARK: Properties
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRounderMTBold", size: 16)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRounderMTBold", size: 16)
        button.backgroundColor = viewTintColor
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: LifeCycle
    init(tintColor: UIColor) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        configViews()
        buildViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Private Methods
    @objc private func nextButtonTapped() {
        nextButtonDidTap?()
    }

    @objc private func getStartedButtonTapped() {
        getStartedButtonDidTap?()
    }
}

// MARK: ViewConfiguration
extension ButtonContainerView: ViewConfiguration {
    func configViews() {}

    func buildViews() {
        addSubview(contentStackView)
        [nextButton, getStartedButton].forEach { contentStackView.addArrangedSubview($0) }
    }

    func setupConstraints() {

        contentStackView.setAnchorsEqual(to: self,
                                         .init(top: 24,
                                               left: 24,
                                               bottom: 36,
                                               right: 24))
        nextButton.equalsWidth(with: getStartedButton, multiplier: 0.5)
    }
}
