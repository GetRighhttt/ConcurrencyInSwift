//
//  DeepIntoAsyncAndAwait.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

/**
 An example again of using Async Await with little more detail.
 
 Async and Await are asynchronous but work in order!
 
 Here we update the views using Task and awaiting for the information.
 */
import SwiftUI

struct DeepIntoAsyncAndAwait: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModelDeepDive()
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.dataArray, id: \.self) { data in
                        Text(data)
                    }
                }.onAppear {
                    Task {
                        await viewModel.addNewWord()
                        await viewModel.changeThis()
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Concurrency")
            }
        }
    }
}

struct DeepIntoAsyncAndAwait_Previews: PreviewProvider {
    static var previews: some View {
        DeepIntoAsyncAndAwait()
    }
}
