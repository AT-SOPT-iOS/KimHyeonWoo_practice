import Foundation

enum NetworkError: Int, Error, LocalizedError {
    case requestEncodingError    // 1
    case responseError           // 2
    case responseDecodingError   // 3
    case unknownError            // 4

    var errorDescription: String? {
        switch self {
        case .requestEncodingError:
            return "요청 생성에 실패했습니다."
        case .responseError:
            return "서버 응답이 없습니다."
        case .responseDecodingError:
            return "데이터 파싱에 실패했습니다."
        case .unknownError:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

