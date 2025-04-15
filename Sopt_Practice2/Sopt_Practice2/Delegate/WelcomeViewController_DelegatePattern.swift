import UIKit

protocol DataBindDelegate: AnyObject {
    func dataBind(id: String)
}

final class WelcomeViewController_DelegatePattern: UIViewController {
    
    weak var delegate: DataBindDelegate?
    var id: String?

    // 이미지 뷰 추가
    private lazy var welcomeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 120, width: 200, height: 200))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "carrot") // Assets에 등록된 이미지 이름
        return imageView
    }()

    // 환영 라벨
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 330, width: view.frame.width - 40, height: 60))
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    // 로그인으로 돌아가기 버튼
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 498, width: 335, height: 58))
        button.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        button.setTitle("다시 로그인하기", for: .normal)
        button.setTitleColor(UIColor(red: 172/255, green: 176/255, blue: 185/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name:"Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // 오늘 날짜를 보여주는 라벨
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 400, width: view.frame.width - 40, height: 30))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        
        self.view.addSubview(welcomeImageView)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(backToLoginButton)
        self.view.addSubview(dateLabel)     // 날짜 라벨
        
        bindID()
        setDate()   // 날짜 세팅 함수 호출
    }

    func setLabelText(id: String?) {
        self.id = id
    }
    
    private func bindID() {
        if let id = self.id {
            self.welcomeLabel.text = "\(id)님\n반가워요!"
        } else {
            self.welcomeLabel.text = "반가워요!"
        }
    }

    @objc
    private func backToLoginButtonDidTap() {
        
        if let id = id {
            delegate?.dataBind(id: id)
        }
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 오늘의 날짜를 yyyy년 MM월 dd일 형식으로 표시
    private func setDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        let today = formatter.string(from: Date())
        dateLabel.text = "최근 접속일자는 \(today)입니다."
    }

}


