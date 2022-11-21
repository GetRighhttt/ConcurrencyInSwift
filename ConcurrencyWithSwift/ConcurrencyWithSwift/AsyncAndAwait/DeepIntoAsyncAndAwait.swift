//
//  DeepIntoAsyncAndAwait.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

/**
 An example again of using Async Await with little more detail.
 */
import SwiftUI

class AsyncDataManagerDeepDive {
    
}

class AsyncAwaitViewModelDeepDive : ObservableObject {
    
    // declare empty array for views
    @Published var dataArray: [String] = []
    
    func addWord1() {
        self.dataArray.append("New Word 1! : \(Thread.current)")
    }
    
    func addWord2() {
        
        // main thread
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("New Word 1! : \(Thread.current)")
        }
        
        // global thread
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let word = "Word 2: \(Thread.current)"
            // back to main thread
            DispatchQueue.main.async{
                self.dataArray.append(word)
            }
        }
    }
}

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
                    viewModel.addWord1()
                    viewModel.addWord2()
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
