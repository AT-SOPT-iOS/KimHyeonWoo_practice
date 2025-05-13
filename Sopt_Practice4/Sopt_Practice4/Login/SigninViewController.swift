import UIKit
import SnapKit
import Then

final class SigninViewController: UIViewController {

    // MARK: — UI
    private let idField = UITextField().then {
        $0.placeholder = "아이디"
        $0.borderStyle = .roundedRect
    }
    private let pwField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
        $0.borderStyle = .roundedRect
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 4
    }

    // MARK: — State
    private var loginId = ""
    private var password = ""

    // MARK: — Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindActions()
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [idField, pwField, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        [idField, pwField, loginButton].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }

    private func bindActions() {
        idField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        pwField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    @objc private func editingChanged(_ tf: UITextField) {
        if tf == idField {
            loginId = tf.text ?? ""
        } else {
            password = tf.text ?? ""
        }
    }

    @objc private func loginTapped() {
        Task {
            do {
                let userId = try await LoginService.shared
                    .postLoginData(loginId: loginId, password: password)

                UserDefaults.standard.set(userId, forKey: "userId")

                let alert = UIAlertController(
                    title: "로그인 성공",
                    // 수정: result.nickname → loginId
                    message: "환영합니다, \(loginId)님!",
                    preferredStyle: .alert
                )
                alert.addAction(.init(title: "확인", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    if let nav = self.navigationController {
                        nav.popViewController(animated: true)
                    } else {
                        self.dismiss(animated: true)
                    }
                })
                present(alert, animated: true)

            } catch let netErr as NetworkError {
                showAlert(title: "로그인 실패", message: netErr.localizedDescription)
            } catch {
                showAlert(title: "로그인 실패", message: error.localizedDescription)
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        a.addAction(.init(title: "확인", style: .default))
        present(a, animated: true)
    }
}
