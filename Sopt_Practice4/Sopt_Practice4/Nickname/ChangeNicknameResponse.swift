import Foundation

struct ChangeNicknameResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String? 
}
