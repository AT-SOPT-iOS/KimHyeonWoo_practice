import UIKit

class AutoLayoutViewController: UIViewController{
    
//        override func viewDidLoad() {
//                super.viewDidLoad()
//
//                self.view.backgroundColor = .white
//                setLayout()
//            }
//
//        private func setLayout() {
//            [바둑알1, 바둑알2, 방어막].forEach {
//                self.view.addSubview($0)
//                $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//
//        NSLayoutConstraint.activate([바둑알1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40), 바둑알1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40), 바둑알1.widthAnchor.constraint(equalToConstant: 20), 바둑알1.heightAnchor.constraint(equalToConstant: 20)])
//
//        NSLayoutConstraint.activate([바둑알2.topAnchor.constraint(equalTo: self.바둑알1.bottomAnchor, constant: 40), 바둑알2.leadingAnchor.constraint(equalTo: self.바둑알1.trailingAnchor, constant: 40), 바둑알2.widthAnchor.constraint(equalToConstant: 20), 바둑알2.heightAnchor.constraint(equalToConstant: 20)])
//
//
//        NSLayoutConstraint.activate([방어막.leadingAnchor.constraint(equalTo: 바둑알2.trailingAnchor, constant: 20), 방어막.topAnchor.constraint(equalTo: 바둑알2.bottomAnchor, constant: 20), 방어막.widthAnchor.constraint(equalToConstant: 60), 방어막.heightAnchor.constraint(equalToConstant: 10)])
//        }
//
//            var 바둑알1: UIView = {
//                let view = UIView(frame: .init(origin: .zero, size: .init(width: 20, height: 20)))
//                view.backgroundColor = .black
//                view.layer.cornerRadius = 10
//                view.clipsToBounds = true
//                return view
//            }()
//
//            var 바둑알2: UIView = {
//                let view = UIView(frame: .init(origin: .zero, size: .init(width: 20,height: 20)))
//                view.backgroundColor = .black
//                view.layer.cornerRadius = 10
//                view.clipsToBounds = true
//                return view
//            }()
//
//            var 방어막: UIView = {
//                let view = UIView()
//                view.backgroundColor = .blue
//                return view
//            }()
//
//
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        let height = UIScreen.main.bounds.height / 4
        let width = UIScreen.main.bounds.width / 2
        
        [yellowView, greenView, blackView, blueView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: view.topAnchor),
            yellowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yellowView.heightAnchor.constraint(equalToConstant: height),
            yellowView.widthAnchor.constraint(equalToConstant: width),
            
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor),
            greenView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            greenView.heightAnchor.constraint(equalToConstant: height),
            greenView.widthAnchor.constraint(equalToConstant: width),
            
            blackView.topAnchor.constraint(equalTo: greenView.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.heightAnchor.constraint(equalToConstant: height),
            blackView.widthAnchor.constraint(equalToConstant: width),
            
            blueView.topAnchor.constraint(equalTo: blackView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: height),
            blueView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
