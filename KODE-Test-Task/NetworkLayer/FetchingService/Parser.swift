//
//  Parser.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 22.12.2023.
//

import Foundation

protocol ParserProtocol {
    func decodeJSON <T: Decodable>(type: T.Type, from data: Data?, completion: @escaping (Result<T, Error>) -> Void)
}

class Parser : ParserProtocol {
    
    func decodeJSON <T: Decodable>(type: T.Type, from data: Data?, completion: @escaping (Result<T, Error>) -> Void)  {
        guard let data = data else {
            completion(.failure(NetworkError.noData))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let parsedData = try? decoder.decode(type.self, from: data) {
            completion(.success(parsedData))
        } else {
            completion(.failure(NetworkError.jsonParsingFailed))
        }
    }
    
}
