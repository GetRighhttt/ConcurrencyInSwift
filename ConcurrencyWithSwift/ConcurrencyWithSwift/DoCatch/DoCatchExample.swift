//
//  DoCatchExample.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

/**
 Now we just populate the views with our view model instance.
 */

import SwiftUI

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
