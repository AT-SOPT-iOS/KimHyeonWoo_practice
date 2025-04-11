//
//  LoginViewController.swift
//  Week_1
//
//  Created by 김현우 on 4/5/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 69, y: 161, width: 236, height: 44))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black    // 글자 색상
        label.textAlignment = .center   // 가운데 정렬
        label.numberOfLines = 2     // 2줄까지 표시
        label.font = UIFont(name: "Pretendard-Bold", size: 16)    // 굵은 폰트
        return label
    }()
    
    // 아이디 입력 필드
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디"   // placeholder=힌트 텍스트
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)    // 글자 크기
        //연한 회색 배경
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        
        // 둥근 테두리(아이디 입력)
        textField.layer.cornerRadius = 8    // 둥근 정도 설정
        textField.layer.masksToBounds = true    // 내부 요소 라운드 범위 넘지 않도록 설정
        
        // 왼쪽 여백을 추가하여 간격을 맞출 수 있음.
        textField.setLeftPaddingPoints(12)
        
        return textField
    }()
    
    // 비밀번호 입력 필드
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        
        textField.setLeftPaddingPoints(12)
        
        return textField
        
    }()
    
    // 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 21, y: 422, width: 332, height: 58))
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // 광고 이미지
    private let adBannerImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 80))
        imageView.image = UIImage(named: "Ad")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    
    // 로그인 버튼 눌렀을 때 호출될 함수
    @objc
    private func loginButtonDidTap() {
        print("Login button did tapped")    // 콘솔 로그
        presentToWelcomeVC()    // 다음 화면으로 전환
        //pushToWelcomeVC()
    }
    
    @objc
    private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc
    private func signupButtonDidTap() {
        print("Sign up button did tapped")
        // 회원가입 화면으로 이동하는 코드 추가 가능
    }

    
    // 생명주기 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white  // 배경색(흰색)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.rightView = passwordToggleButton // 텍스트 필드 오른쪽에 버튼 추가
        passwordTextField.rightViewMode = .always
        setLayout()     // UI 요소 화면에 배치
        
    }
    // UI 요소들을 뷰에 추가하는 함수
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton, signupButton, adBannerImageView].forEach {
            self.view.addSubview($0)    // 하나씩 화면에 추가
        }
    }
    
    // 모달 방식으로 Welcome 화면 보여주기
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .formSheet   // 모달 형태로 보여주기
        //        welcomeViewController.id = idTextField.text   // 아이디를 전달
        welcomeViewController.setLabelText(id: idTextField.text)    // 모달로 띄움
        self.present(welcomeViewController, animated: true)
    }
    
    // 푸시 방식으로 Welcome 화면 이동
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        //        welcomeViewController.id = idTextField.text
        welcomeViewController.setLabelText(id: idTextField.text)
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    private let passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }()

    private lazy var signupButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 21, y: 490, width: 332, height: 44))
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        button.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
        return button
    }()

}
// (주의! 클래스 밖에 선언해야됨.. 아니면 오류 발생)
    extension UITextField {
        // 왼쪽 여백 추가 함수
        func setLeftPaddingPoints(_ amount: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    }
