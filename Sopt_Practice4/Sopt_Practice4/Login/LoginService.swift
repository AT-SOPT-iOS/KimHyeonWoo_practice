import Foundation

final class LoginService {
    static let shared = LoginService()
    private init() {}

    func makeRequestBody(loginId: String, password: String) -> Data? {
        do {
            let request = LoginRequest(loginId: loginId, password: password)
            return try JSONEncoder().encode(request)
        } catch {
            print("LoginService > makeRequestBody 인코딩 실패:", error)
            return nil
        }
    }

    func makeRequest(body: Data?) -> URLRequest {
        let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/auth/signin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        return request
    }

    /// 로그인 후 userId만 반환
    func postLoginData(loginId: String, password: String) async throws -> Int {
        guard let body = makeRequestBody(loginId: loginId, password: password) else {
            throw NetworkError.requestEncodingError
        }
        let request = makeRequest(body: body)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🔍 Login 응답 JSON:", jsonString)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError(rawValue: httpResponse.statusCode) ?? NetworkError.unknownError
        }
        do {
            let wrapper = try JSONDecoder().decode(LoginResponseWrapper.self, from: data)
            return wrapper.data.userId
        } catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
}
