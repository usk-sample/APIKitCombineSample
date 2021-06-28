//
//  ContentView.swift
//  APIKitCombineSample
//
//  Created by Yusuke Hasegawa on 2021/06/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach.init(self.viewModel.items, id: \.id) { item in
                    Text(item.fullName)
                }
            }
            .navigationBarTitle(Text("Serach Respositories"), displayMode: .inline)
            .navigationBarItems(trailing: Button.init("Search", action: { self.viewModel.doSearch() }))
            .alert(isPresented: self.$viewModel.hasError, content: {
                Alert.init(title: Text("Error"), message: Text(self.viewModel.errorText), dismissButton: .default(Text("OK")))
            })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
