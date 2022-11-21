//
//  DoCatchExample.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

/**
 We want to understand why we use do-catch-try- and throws in SwiftUI. And the reason is
 to handle errors.
 This is where we will demonstrate the significance of that.
 */

import SwiftUI

/*
 We usually use a data source to fetch data from in our view model
 so this will act as our data source.
 */
class DoCatchDataManager {
    
    let isActive: Bool = true
    
    // without success and failure
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("First Title.", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    // with success and failure
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text!")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    // with try and throws
    func getTitle3() throws -> String {
        //        if isActive {
        //            return "New Text"
        //        } else {
        throw URLError(.appTransportSecurityRequiresSecureConnection)
        //        }
    }
    
    // with tricky trys
    func getTitle4() throws -> String {
        if isActive {
            return "Last Text"
        } else {
            throw URLError(.appTransportSecurityRequiresSecureConnection)
        }
    }
}


/*
 Here is the view model we typically pass into our views.
 */
class DoCatchViewModel : ObservableObject {
    
    @Published var text: String = "Starting Text"
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
            
            let newTitle = try? dataManager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            
            let lastTitle = try dataManager.getTitle4()
            self.text = lastTitle
            
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchExample: View {
    // create our view model instance
    @StateObject var viewModel = DoCatchViewModel()
    
    var body: some View {
        
        // some basic text to go over how we retrieve data
        Text(viewModel.text)
            .frame(width: 200, height: 200)
            .background(Color.yellow)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoCatchExample_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchExample()
    }
}
