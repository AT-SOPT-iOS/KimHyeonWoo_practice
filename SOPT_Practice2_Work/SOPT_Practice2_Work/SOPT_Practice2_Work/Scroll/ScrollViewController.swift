import UIKit

class ScrollViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    private var colorViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
            colorViews.append(view)
        }
        

        let halfHeight = UIScreen.main.bounds.height / 2
        
        for (index, view) in colorViews.enumerated() {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                view.heightAnchor.constraint(equalToConstant: halfHeight)
            ])
            
            if index == 0 {
                view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            } else {
                view.topAnchor.constraint(equalTo: colorViews[index - 1].bottomAnchor).isActive = true
            }
            
            if index == colorViews.count - 1 {
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            }
        }
    }
    
//    private let scrollView = UIScrollView()
//        private let contentView = UIView()
//
//        private let redView = UIView()
//        private let orangeView = UIView()
//        private let yellowView = UIView()
//        private let greenView = UIView()
//        private let blueView = UIView()
//        private let purpleView = UIView()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            view.backgroundColor = .white
//
//            redView.backgroundColor = .red
//            orangeView.backgroundColor = .orange
//            yellowView.backgroundColor = .yellow
//            greenView.backgroundColor = .green
//            blueView.backgroundColor = .blue
//            purpleView.backgroundColor = .purple
//
//            setLayout()
//        }
//
//        private func setLayout() {
//            scrollView.translatesAutoresizingMaskIntoConstraints = false
//            contentView.translatesAutoresizingMaskIntoConstraints = false
//            redView.translatesAutoresizingMaskIntoConstraints = false
//            orangeView.translatesAutoresizingMaskIntoConstraints = false
//            yellowView.translatesAutoresizingMaskIntoConstraints = false
//            greenView.translatesAutoresizingMaskIntoConstraints = false
//            blueView.translatesAutoresizingMaskIntoConstraints = false
//            purpleView.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(scrollView)
//            scrollView.addSubview(contentView)
//
//            [redView, orangeView, yellowView, greenView, blueView, purpleView].forEach {
//                contentView.addSubview($0)
//            }
//
//
//            NSLayoutConstraint.activate([
//                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//
//
//            NSLayoutConstraint.activate([
//                contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//                contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
//                contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
//                contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
//                contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
//            ])
//
//
//            let heightConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//            heightConstraint.priority = .defaultLow
//            heightConstraint.isActive = true
//
//            let boxHeight: CGFloat = 300
//
//
//            NSLayoutConstraint.activate([
//                redView.topAnchor.constraint(equalTo: contentView.topAnchor),
//                redView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//                redView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                redView.heightAnchor.constraint(equalToConstant: boxHeight),
//
//                orangeView.topAnchor.constraint(equalTo: contentView.topAnchor),
//                orangeView.leadingAnchor.constraint(equalTo: redView.trailingAnchor),
//                orangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//                orangeView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                orangeView.heightAnchor.constraint(equalToConstant: boxHeight)
//            ])
//
//
//            NSLayoutConstraint.activate([
//                yellowView.topAnchor.constraint(equalTo: redView.bottomAnchor),
//                yellowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//                yellowView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                yellowView.heightAnchor.constraint(equalToConstant: boxHeight),
//
//                greenView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
//                greenView.leadingAnchor.constraint(equalTo: yellowView.trailingAnchor),
//                greenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//                greenView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                greenView.heightAnchor.constraint(equalToConstant: boxHeight)
//            ])
//
//
//            NSLayoutConstraint.activate([
//                blueView.topAnchor.constraint(equalTo: yellowView.bottomAnchor),
//                blueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//                blueView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                blueView.heightAnchor.constraint(equalToConstant: boxHeight),
//
//                purpleView.topAnchor.constraint(equalTo: greenView.bottomAnchor),
//                purpleView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor),
//                purpleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//                purpleView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
//                purpleView.heightAnchor.constraint(equalToConstant: boxHeight),
//                purpleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            ])
//        }
}
