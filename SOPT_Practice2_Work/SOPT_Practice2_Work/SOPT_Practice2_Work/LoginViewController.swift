import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.15, alpha: 1) // 더 진한 회색 배경
        textField.textColor = UIColor(white: 0.8, alpha: 1) // 텍스트 색을 더 진한 회색
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 0)) // 오른쪽으로 이동
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none // 아이디 입력 시 첫 문자는 소문자
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.15, alpha: 1) // 더 진한 회색 배경
        textField.textColor = UIColor(white: 0.8, alpha: 1) // 텍스트 색을 더 진한 회색
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 0)) // 오른쪽으로 이동
        textField.leftViewMode = .always
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5 // 얇은 테두리
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.lightGray, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal) // 기본적으로 숨김 상태
        return button
    }()
    
    private let clearButtonForId: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.isHidden = true // 초기에는 숨김
        return button
    }()
    
    private let clearButtonForPassword: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.isHidden = true // 초기에는 숨김
        return button
    }()
    
    private let idFindLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디 찾기"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let passwordFindLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 찾기"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let separatorLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5) // 구분선 색상
            return view
        }()
    
    private let accountLabel: UILabel = {
            let label = UILabel()
            label.text = "아직 계정이 없으신가요?"
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: "TVING ID 회원가입하기", attributes: attributes)
        label.attributedText = attributedString
        label.textColor = .lightGray
        return label
    }()

    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(eyeButton)
        view.addSubview(clearButtonForId)
        view.addSubview(clearButtonForPassword)
        view.addSubview(idFindLabel)
        view.addSubview(passwordFindLabel)
        view.addSubview(separatorLine)
        view.addSubview(accountLabel)
        view.addSubview(signUpLabel)
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        // Eye button (Password visibility toggle) position (Right end, no gap)
        eyeButton.snp.makeConstraints { make in
            make.right.equalTo(passwordTextField.snp.right).inset(0) // No gap, right edge
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(30)
        }

        // Clear button for password (Positioned directly next to the eye button)
        clearButtonForPassword.snp.makeConstraints { make in
            make.right.equalTo(eyeButton.snp.left).inset(0) // No gap, right next to eye button
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(30)
        }
        
        clearButtonForId.snp.makeConstraints { make in
            make.right.equalTo(idTextField.snp.right).inset(10)
            make.top.equalTo(idTextField.snp.top).offset(10)
            make.width.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        idFindLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.equalTo(view).inset(95)
        }
        
        passwordFindLabel.snp.makeConstraints { make in
            make.top.equalTo(idFindLabel.snp.top)
            make.right.equalTo(view).inset(70)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(idFindLabel.snp.top)
            make.centerX.equalTo(view).offset(5)
            make.width.equalTo(1.5)
            make.height.equalTo(15)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(idFindLabel.snp.bottom).offset(30)
            make.left.equalTo(view).inset(65)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordFindLabel.snp.bottom).offset(30)
            make.right.equalTo(view).inset(45)
        }
    }

    private func setupActions() {
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        clearButtonForId.addTarget(self, action: #selector(clearIdTextField), for: .touchUpInside)
        clearButtonForPassword.addTarget(self, action: #selector(clearPasswordTextField), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func idTextFieldChanged() {
        let isIdNotEmpty = !(idTextField.text?.isEmpty ?? true)
        
        // 아이디 취소 버튼 상태 제어
        clearButtonForId.isHidden = !isIdNotEmpty
        
        // 로그인 버튼 활성화 조건
        let isPasswordNotEmpty = !(passwordTextField.text?.isEmpty ?? true)
        loginButton.isEnabled = isIdNotEmpty && isPasswordNotEmpty
        idTextField.layer.borderColor = isIdNotEmpty ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        passwordTextField.layer.borderColor = isPasswordNotEmpty ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor

        // 로그인 버튼 색상 변경
        if isIdNotEmpty && isPasswordNotEmpty {
            loginButton.backgroundColor = .red
            loginButton.setTitleColor(.white, for: .normal)
        } else {
            loginButton.backgroundColor = .black
            loginButton.setTitleColor(.lightGray, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupActions()

        // 초기 상태에서 비밀번호 텍스트 필드가 비어있으면 눈 모양 버튼을 숨김
        eyeButton.isHidden = true
    }

    @objc private func passwordTextFieldChanged() {
        let isPasswordNotEmpty = !(passwordTextField.text?.isEmpty ?? true)
        
        // 비밀번호 취소 버튼 상태 제어
        clearButtonForPassword.isHidden = !isPasswordNotEmpty

        // 비밀번호 필드에 텍스트가 있으면 눈 모양 버튼 보이기, 없으면 숨기기
        eyeButton.isHidden = !isPasswordNotEmpty

        // 로그인 버튼 활성화 상태 업데이트
        let isIdNotEmpty = !(idTextField.text?.isEmpty ?? true)
        loginButton.isEnabled = isIdNotEmpty && isPasswordNotEmpty
        idTextField.layer.borderColor = isIdNotEmpty ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        passwordTextField.layer.borderColor = isPasswordNotEmpty ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor

        // 로그인 버튼 색상 변경
        if isIdNotEmpty && isPasswordNotEmpty {
            loginButton.backgroundColor = .red
            loginButton.setTitleColor(.white, for: .normal)
        } else {
            loginButton.backgroundColor = .black
            loginButton.setTitleColor(.lightGray, for: .normal)
        }
    }

    @objc private func togglePasswordVisibility() {
        // 비밀번호 숨김/보임 기능 반대로 변경
        passwordTextField.isSecureTextEntry.toggle()
        
        // 비밀번호 보이기/숨기기 상태에 따라 아이콘 변경
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }


    @objc private func clearIdTextField() {
        idTextField.text = ""
        idTextFieldChanged()  // 로그인 버튼 상태 갱신
    }

    @objc private func clearPasswordTextField() {
        passwordTextField.text = ""
        passwordTextFieldChanged()  // 취소 버튼 숨기기
    }

    @objc private func loginButtonTapped() {
        let id = idTextField.text ?? ""
        let welcomeVC = WelcomeViewController()
        welcomeVC.setEmailLabelText(id) // Dynamically set the email text
        let navigationController = UINavigationController(rootViewController: welcomeVC)
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func backButtonTapped() {
        // 뒤로 가기 버튼 동작 구현
        self.dismiss(animated: true, completion: nil)
    }
}
