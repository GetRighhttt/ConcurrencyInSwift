//
//  ContentView.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            DeepIntoAsyncAndAwait()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
