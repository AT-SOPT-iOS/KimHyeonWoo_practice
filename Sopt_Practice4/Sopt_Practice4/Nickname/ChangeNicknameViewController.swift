import UIKit
import SnapKit
import Then

final class ChangeNicknameViewController: UIViewController {
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "새 닉네임을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.setLeftPadding(8)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let changeButton = UIButton(type: .system).then {
        $0.setTitle("닉네임 변경", for: .normal)
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .systemBlue
        $0.setTitleColor(.white, for: .normal)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePresentation()
        title = "닉네임 변경"
        view.backgroundColor = .white
        setupLayout()
        bindActions()
    }

    private func configurePresentation() {
        modalPresentationStyle = .pageSheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }

    private func setupLayout() {
        view.addSubview(stackView)
        [nicknameTextField, changeButton].forEach { stackView.addArrangedSubview($0) }
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }

    private func bindActions() {
        changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
    }

    @objc private func didTapChange() {
        let newNick = nicknameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !newNick.isEmpty else {
            showAlert(title: "입력 오류", message: "새 닉네임을 입력해주세요.")
            return
        }

        Task {
            do {
                let response = try await ChangeNicknameService.shared
                    .changeNickname(newNickname: newNick)
                showAlert(title: "성공", message: response.message) {
                    self.dismiss(animated: true)
                }
            } catch {
                showAlert(title: "변경 실패", message: error.localizedDescription)
            }
        }
    }

    private func showAlert(
        title: String,
        message: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "확인", style: .default) { _ in completion?() })
        present(alert, animated: true)
    }
}

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let padding = UIView(
            frame: .init(x: 0, y: 0, width: amount, height: frame.height)
        )
        leftView = padding
        leftViewMode = .always
    }
}
