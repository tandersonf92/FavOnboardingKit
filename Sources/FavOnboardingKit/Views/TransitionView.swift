import UIKit

final class TransitionView: UIView {

    // MARK: Properties
    private var slides: [Slide]
    private let barColor: UIColor
    private var timer: DispatchSourceTimer?
    private (set) var index: Int = -1

    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var barViews: [AnimatedBarView] = []

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleView: TitleView = TitleView()

    // MARK: LifeCycle
    init(slides: [Slide], barColor: UIColor) {
        self.slides = slides
        self.barColor = barColor
        super.init(frame: .zero)
        setupBarViews()
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: Private Methods
    private func setupBarViews() {
        slides.forEach { _ in
            barViews.append(AnimatedBarView(barColor: barColor))
        }
        barViews.forEach { barStackView.addArrangedSubview($0) }
    }

    private func buildTimerIfNeeded() {
        guard timer == nil else { return }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(3), leeway: .seconds(1))
        timer?.setEventHandler(handler: {
            DispatchQueue.main.async { [weak self] in
                self?.showNext()
            }
        })
    }

    private func showNext() {
        let nextImage: UIImage
        let nextTitle: String
        let nextBarView: AnimatedBarView

        if slides.indices.contains(index + 1) {
            guard let image = slides[index + 1].image else { return }
            nextTitle = slides[index + 1].title
            nextImage = image
            nextBarView = barViews[index + 1]
            index += 1
        } else {
            barViews.forEach { $0.resetAnimating() }
            guard let image = slides[0].image else { return }
            nextImage = image
            nextTitle = slides[0].title
            nextBarView = barViews[0]
            index = 0
        }

        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            self.imageView.image = nextImage
        }
        titleView.setTitle(text: nextTitle)
        nextBarView.startAnimating()
    }

    // MARK: Handle Tap
    func handleTap(direction: Direction) {
        switch direction {
        case .left:
            barViews[index].resetAnimating()
            if barViews.indices.contains(index - 1) {
                barViews[index - 1].resetAnimating()
            }
            index -= 2
            timer?.cancel()
            timer = nil
            start()
        case .right:
            barViews[index].completeAnimation()
        }

        timer?.cancel()
        timer = nil
        start()
    }

    // MARK: Start and Stop
    func start() {
        buildTimerIfNeeded()
        timer?.resume()
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }
}

extension TransitionView: ViewConfiguration {
    func configViews() {}

    func buildViews() {
        [contentStackView, barStackView].forEach { addSubview($0) }
        [imageView, titleView].forEach { contentStackView.addArrangedSubview($0) }
    }

    func setupConstraints() {

        contentStackView.setAnchorsEqual(to: self)

        barStackView.size(height: 4)
        barStackView.anchor(top: topAnchor,
                            leading: leadingAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 24,
                            paddingLeft: 24,
                            paddingRight: 24)

        imageView.equalsHeight(with: contentStackView, multiplier: 0.8)
    }
}
