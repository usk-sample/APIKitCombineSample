//
//  SearchResponse.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import Foundation

struct SearchResponse: Decodable {
    let items: [SearchItem]
}

struct SearchItem: Decodable, Identifiable {
    let id: Int
    let fullName: String
}
