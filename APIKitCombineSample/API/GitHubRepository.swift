//
//  GitHubRepository.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import Foundation
import APIKit

class GitHubRepository {
    
    //Search API
    struct SearchRepositories: GitHubRequestProtocol {
        
        //https://developer.github.com/v3/search

        let query: String
        let decoder: JSONDecoder
        
        let method: HTTPMethod = .get
        let path: String = "search/repositories"
//        let path: String = "/search/repositories" //test for error

        var params: [String: Any] {
            return [
                "q": query
            ]
        }
        
        typealias Response = SearchResponse

    }
    
    private init() { }
    
}
