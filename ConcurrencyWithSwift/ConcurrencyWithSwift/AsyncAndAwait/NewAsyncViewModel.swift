//
//  NewAsyncViewModel.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import Foundation
import SwiftUI

class AsyncAwaitViewModelDeepDive : ObservableObject {
    
    // declare empty array for views
    @Published var dataArray: [String] = []
    
    /**
     without async and await:
     
     
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
             DispatchQueue.main.async{ // back to main thread
                 self.dataArray.append(word)
                 
                 let word2 = "Word3: \(Thread.current)"
                 self.dataArray.append(word2)
             }
         }
     }
     */
    
    
    /**
     Here is async and await:
     
     Sometimes async and await will run on a background thread. But it's not always.
     
     await = suspension point in the task.
     
     So it's best practice to switch back onto main actor or whatever actor afterwards.
     
     Best practice to specify the thread.
     
     Code executes in order even though it is asynchronous.
     */
    func addNewWord() async {
        let word1 = "Word1: \(Thread.current)"
        self.dataArray.append(word1)
        
        // we can use sleep to add a delay to async and await.
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        // go back to main thread
        await MainActor.run {
            let word2 = "Word2: \(Thread.current)"
            self.dataArray.append(word2)
        }
    }
    
}
