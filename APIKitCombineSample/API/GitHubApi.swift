//
//  GitHubApi.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import Foundation
import APIKit

class GitHubApi {
    
    private let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    private let session: Session
        
    init(session: Session = .shared) {
        self.session = session
    }
        
}

extension GitHubApi {
    
    func searchRepository(query: String) -> SessionTaskPublisher<GitHubRepository.SearchRepositories> {
        let request = GitHubRepository.SearchRepositories(query: query, decoder: decoder)
        return session.sessionTaskPublisher(for: request, callbackQueue: .main)        
    }
    
}
