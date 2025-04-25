import UIKit
import SnapKit

class WelcomeViewController: UIViewController {

    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TVING_main")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디 님 \n반가워요!"
        label.font = UIFont(name: "Pretendard-Medium", size: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.black
        view.addSubview(welcomeImageView)
        view.addSubview(emailLabel)
        view.addSubview(mainButton)

        // 이미지 어셋 위치 설정 (상단과 20pt 여백)
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.right.equalTo(view).inset(0)
            make.height.equalTo(200) // 이미지 크기 조정
        }
        
        // 이메일 라벨 위치 설정
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(20)
        }
        
        // 메인 버튼을 최하단으로 위치
        mainButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
    }

    @objc private func mainButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    // 이메일 라벨 텍스트 업데이트 메서드
    func setEmailLabelText(_ text: String) {
        emailLabel.text = "\(text) 님 \n반가워요!"
    }
}
