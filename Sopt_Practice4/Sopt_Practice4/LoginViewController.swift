// LoginViewController.swift
import UIKit
import SnapKit
import Then

final class LoginViewController: UIViewController {
    private var loginId = ""
    private var password = ""
    private var nickName = ""

    private let idTextField = UITextField().then {
        $0.placeholder = "아이디를 입력하세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 4
        $0.setLeftPadding(8)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let passwordTextField = UITextField().then {
        $0.placeholder = "패스워드를 입력하세요."
        $0.isSecureTextEntry = true
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 4
        $0.setLeftPadding(8)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let nickNameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 4
        $0.setLeftPadding(8)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let registerButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemPink
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let changeNicknameButton = UIButton(type: .system).then {
        $0.setTitle("닉네임 변경", for: .normal)
        $0.backgroundColor = .systemPink
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.isHidden = true
    }

    private let infoViewButton = UIButton(type: .system).then {
        $0.setTitle("회원정보 조회", for: .normal)
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        bindActions()
        changeNicknameButton.isHidden = true
    }

    private func setLayout() {
        [idTextField,
         passwordTextField,
         nickNameTextField,
         registerButton,
         loginButton,
         changeNicknameButton,
         infoViewButton
        ].forEach { stackView.addArrangedSubview($0) }

        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(150)
        }
    }

    private func bindActions() {
        idTextField.addTarget(self,
                              action: #selector(textFieldDidEditing(_:)),
                              for: .editingChanged)
        passwordTextField.addTarget(self,
                                    action: #selector(textFieldDidEditing(_:)),
                                    for: .editingChanged)
        nickNameTextField.addTarget(self,
                                    action: #selector(textFieldDidEditing(_:)),
                                    for: .editingChanged)
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTap),
                                 for: .touchUpInside)
        loginButton.addTarget(self,
                              action: #selector(loginButtonTap),
                              for: .touchUpInside)
        changeNicknameButton.addTarget(self,
                                       action: #selector(changeNicknameTap),
                                       for: .touchUpInside)
        infoViewButton.addTarget(self,
                                 action: #selector(infoViewButtonTap),
                                 for: .touchUpInside)
    }

    @objc private func registerButtonTap() {
        Task {
            do {
                let response = try await RegisterService.shared
                    .PostRegisterData(
                        loginId: loginId,
                        password: password,
                        nickName: nickName
                    )
                let alert = UIAlertController(
                    title: "계정 생성 성공",
                    message: "환영합니다, \(response.nickname)님! (ID: \(response.userId))",
                    preferredStyle: .alert
                )
                alert.addAction(.init(title: "확인", style: .default))
                present(alert, animated: true)
            } catch {
                showAlert(title: "계정 생성 실패", message: error.localizedDescription)
            }
        }
    }

    @objc private func loginButtonTap() {
        Task {
            do {
                let userId = try await LoginService.shared
                    .postLoginData(loginId: loginId,
                                   password: password)

                UserDefaults.standard.set(userId, forKey: "userId")
                changeNicknameButton.isHidden = false

                let alert = UIAlertController(
                    title: "로그인 성공",
                    message: "환영합니다, \(loginId)님!",
                    preferredStyle: .alert
                )
                alert.addAction(.init(title: "확인", style: .default))
                present(alert, animated: true)

            } catch let netErr as NetworkError {
                showAlert(title: "로그인 실패", message: netErr.localizedDescription)
            } catch {
                showAlert(title: "로그인 실패", message: error.localizedDescription)
            }
        }
    }

    @objc private func changeNicknameTap() {
        let changeVC = ChangeNicknameViewController()
        changeVC.modalPresentationStyle = .pageSheet
        present(changeVC, animated: true)
    }

    @objc private func infoViewButtonTap() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }

    @objc private func textFieldDidEditing(_ textField: UITextField) {
        switch textField {
        case idTextField:
            loginId = textField.text ?? ""
        case passwordTextField:
            password = textField.text ?? ""
        default:
            nickName = textField.text ?? ""
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let padding = UIView(frame: .init(x: 0, y: 0, width: amount, height: frame.height))
        leftView     = padding
        leftViewMode = .always
    }
}
