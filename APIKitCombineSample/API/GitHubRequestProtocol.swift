//
//  GitHubRequestProtocol.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import Foundation
import APIKit

protocol GitHubRequestProtocol: Request {
    var params: [String: Any] { get } // request parameter
    var decoder: JSONDecoder { get }  // decoder for response
}

extension GitHubRequestProtocol {
    
    /// endpoint
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/") else { fatalError() }
        return url
    }
    
    /// request parameter
    var parameters: Any? {
        return params
    }
    
    #if DEBUG
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        debugPrint(urlRequest.url?.absoluteString ?? "")
        return urlRequest
    }
    #endif
    
}

extension GitHubRequestProtocol where Response: Decodable {
    
    var dataParser: DataParser {
        return APIDataParser<Response>(decoder: decoder)
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let response = object as? Response else {
            throw ResponseError.unexpectedObject(object)
        }
        return response
    }
    
}

struct APIDataParser<T: Decodable>: APIKit.DataParser {
    
    let decoder: JSONDecoder //Decoder
    
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        // do decode
        return try decoder.decode(T.self, from: data)
    }
}
