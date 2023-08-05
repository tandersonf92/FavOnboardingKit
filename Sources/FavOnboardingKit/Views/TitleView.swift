import UIKit

final class TitleView: UIView {

    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    // MARK: LifeCycle◊◊
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Configuration Methods
    func setTitle(text: String?) {
        titleLabel.text = text
    }


    // MARK: Selectors
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
