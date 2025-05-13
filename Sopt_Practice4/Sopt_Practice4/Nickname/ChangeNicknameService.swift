import Foundation

final class ChangeNicknameService {
    static let shared = ChangeNicknameService()
    private init() {}

    func changeNickname(newNickname: String) async throws -> ChangeNicknameResponse {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        guard userId != 0 else {
            throw NSError(domain: "ChangeNicknameService", code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "로그인 후 이용해주세요."])
        }

        let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(userId)", forHTTPHeaderField: "userId")

        let body = ChangeNicknameRequest(nickname: newNickname)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(ChangeNicknameResponse.self, from: data)
    }
}
