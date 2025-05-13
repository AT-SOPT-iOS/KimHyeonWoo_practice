import Foundation

// 실제로 서버 통신이 진행되는 부분의 코드
// 회원가입

class RegisterService {
    
    // 싱글톤 객체 생성을 진행
    static let shared = RegisterService()
    private init() {}
    
    // URL Session에 넣어줄 URL Request를 만드는 부분
    // 회원가입은 requestBody가 필요함. 이를 위해서 유저네임, 비번, 닉네임을 받아서 request 형식의 데이터 모델로 인코딩을 해주는 과정
    func makeRequestBody(loginId: String,
                         password: String,
                         nickName: String) -> Data? {
        do {
            let data = RegisterRequest(loginId: loginId,
                                       password: password,
                                       nickname: nickName)
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            return requestBody
        } catch {
            print(error)
            return nil
        }
    }
    
    
    // URL Session에 넣어줄 URL Request를 만드는 부분
    func makeRequest(body: Data?) -> URLRequest {
        let url = URL(string: "https://api.atsopt-seminar4.site/api/v1/auth/signup")! // String 형식이었던 URL을 URL객체로 만들어주고
        var request = URLRequest(url: url) // 해당 URL을 이용해서 URL Request 객체를 만들어 줍니다!
        request.httpMethod = "POST" // 이후, 어떤 HTTP Method를 사용할건지,
        let header = ["Content-Type": "application/json"] // 어떤 헤더를 사용할 것인지에 대해 코드 작성
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        // dictionary를 사용해서, 헤더를 선언하고, key와 value값을 통해 Request와 헤더를 설정해줌
        if let body = body {
            request.httpBody = body
        }
        // 이후에 아까 받아온 Body를 넣어줌
        
        return request
    }
    
    // 만들어진 Request를 이용해서 실제로 서버와 통신을 진행하는 부분
    func PostRegisterData(loginId: String,
                          password: String,
                          nickName: String) async throws ->  RegisterResponseBody{
        
        // makeRequestBody 함수를 이용해서, 리퀘스트 바디를 만들어줍니다! 실패할 경우, 아까 NetworkError에서 선언한 오류들을 던지게 됩니다
        guard let body = makeRequestBody(loginId: loginId,
                                         password: password,
                                         nickName: nickName) else {
            throw NetworkError.requestEncodingError
        }
        
        let request = makeRequest(body: body)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(RegisterResponseWrapper.self, from: data)
            return decoded.data
        } catch {
            print("디코딩 실패:", error)
            throw NetworkError.responseDecodingError
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
    
}
