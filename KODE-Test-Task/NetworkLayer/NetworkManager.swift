//
//  NetworkManager.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation

protocol Networking {
    func fetchUsersData(requestStatus: RequestStatus, completion: @escaping (Result<Employee, Error>) -> Void)
}

class NetworkManager : Networking {
    
    let fetchingService : FetchingServiceProtocol?
    
    init(fetchingService: FetchingServiceProtocol? = FetchingService()) {
        self.fetchingService = fetchingService
    }
    
    let url = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
    
    func fetchUsersData(requestStatus: RequestStatus, completion: @escaping (Result<Employee, Error>) -> Void) {
        guard let fetchingService else { return }
        fetchingService.getData(from: url, requestStatus: requestStatus, completion: completion)
    }
    
}
