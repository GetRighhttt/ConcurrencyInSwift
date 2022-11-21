//
//  ViewModel.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import Foundation


/**
 We want to understand why we use do-catch-try- and throws in SwiftUI. And the reason is
 to handle errors.
 This is where we will demonstrate the significance of that.
 
 We use a view model to do so.
 */
class DoCatchViewModel : ObservableObject {
    
    @Published var text: String = "Starting Text"
    
    // get an instance of our data 
    let dataManager = DoCatchDataManager()
    
    func fetchTitle() {
        // getTitle1()
        //        let returnedValue = dataManager.getTitle()
        //        if let newTitle = returnedValue.title {
        //            self.text = newTitle
        //        } else if let error = returnedValue.error {
        //            self.text = error.localizedDescription
        //        }
        //    }
        
        // getTitle2()
        //        let result = dataManager.getTitle2()
        //
        //        switch result {
        //        case .success(let newTitle):
        //            self.text = newTitle
        //        case .failure(let error):
        //            self.text = error.localizedDescription
        //        default: break
        //        }
        
        /**
         here is where we show the do-catch and optional try. With an optional try, if it doesn't
         work, the next try will still work normally. This only happens with an optional try.
         */
        do {
            
            // optional try
            let newTitle = try? dataManager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            
            // still runs even when optional try fails
            let lastTitle = try dataManager.getTitle4()
            self.text = lastTitle
            
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}
