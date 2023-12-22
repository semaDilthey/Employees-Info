//
//  FetchingService.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 09.12.2023.
//

import Foundation

protocol FetchingServiceProtocol {
    func getData<T: Decodable>(from urlString: String, requestStatus: RequestStatus, completion: @escaping (Result<T, Error>) -> Void)
}

class FetchingService : FetchingServiceProtocol {
    
    let parser : ParserProtocol = Parser()
    
    func getData<T: Decodable>(from urlString: String, requestStatus: RequestStatus, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = getHttpsStatus(url: url, requestStatus: requestStatus)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? NSError, error.code == NSURLErrorSecureConnectionFailed {
                print("SSL Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            self.parser.decodeJSON(type: T.self, from: data, completion: completion)
        }
        
        task.resume()
    }
    
    
    private func getHttpsStatus(url: URL, requestStatus: RequestStatus) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Установка HTTP-заголовков
        switch requestStatus {
        case .success:
            request.addValue("code=200, example=success", forHTTPHeaderField: "Prefer")
        case .randomTest:
            request.addValue("code=200, dynamic=true", forHTTPHeaderField: "Prefer")
        case .error:
            request.addValue("code=500, example=error-500", forHTTPHeaderField: "Prefer")
        }
        return request
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingFailed
}

enum RequestStatus {
    case success
    case randomTest
    case error
}
