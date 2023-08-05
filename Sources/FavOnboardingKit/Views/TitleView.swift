import UIKit

final class TitleView: UIView {

    private let themeFont: UIFont

    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = themeFont
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    // MARK: LifeCycle◊◊
    init(themeFont: UIFont) {
        self.themeFont = themeFont
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Configuration Methods
    func setTitle(text: String?) {
        titleLabel.text = text
    }
}

// MARK: View Configuration
extension TitleView: ViewConfiguration {

    func configViews() {}

    func buildViews() {
        addSubview(titleLabel)
    }

     func setupConstraints() {
         titleLabel.setAnchorsEqual(to: self,
                                    .init(top: 24,
                                          left: 36,
                                          bottom: 36,
                                          right: 36))
    }
}
