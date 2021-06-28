//
//  SerachViewModel.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {    
    
    private let apiClient = GitHubApi()
    private var cancellations = Set<AnyCancellable>()
    
    @Published var items: [SearchItem] = .init()
    @Published var hasError: Bool = false
    @Published var errorText: String = ""
    
}

extension SearchViewModel {
    
    func doSearch() {
        
        apiClient.searchRepository(query: "APIKit")
            .map({ $0.items })
            .sink { [weak self] completion in
                switch completion {
                case .finished: debugPrint("finished")
                case .failure(let error):
                    debugPrint(error)
                    self?.hasError = true
                    
                    switch error {
                    case .requestError(let error):
                        self?.errorText = "Request Error: " + error.localizedDescription
                    case .responseError(let error):
                        self?.errorText = "Response Error: " + error.localizedDescription
                    case .connectionError(let error):
                        self?.errorText = "Connection Error: " + error.localizedDescription
                    }
                    
                }
            } receiveValue: { [weak self] items in
                self?.items = items
            }.store(in: &cancellations)

        
    }
    
}
