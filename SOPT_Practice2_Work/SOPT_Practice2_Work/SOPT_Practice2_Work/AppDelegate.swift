import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 윈도우 객체 생성
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 첫 번째 화면으로 LoginViewController를 설정
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        // 네비게이션 컨트롤러를 루트 뷰 컨트롤러로 설정
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}
