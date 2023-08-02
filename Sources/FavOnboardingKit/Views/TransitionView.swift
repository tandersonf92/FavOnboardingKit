import UIKit

final class TransitionView: UIView {

    // MARK: Properties
    

    // MARK: LifeCycle
    init() {
        super.init(frame: .zero)
        configViews()
        buildViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Private Methods

    // MARK: Selectors

    // MARK: View Configuration
    private func configViews() {

    }

    private func buildViews() {

    }

    private func setupConstraints() {

    }
}

//// MARK: ViewConfiguration
//extension TransitionView: ViewConfiguration {
//
//    func configViews() {
//
//    }
//
//    func buildViews() {
//
//    }
//
//    func setupConstraints() {
//
//    }
//}
