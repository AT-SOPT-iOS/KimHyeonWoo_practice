import Foundation

struct LoginResponseWrapper: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: LoginResponseBody
}

struct LoginResponseBody: Codable {
    let userId: Int
}
