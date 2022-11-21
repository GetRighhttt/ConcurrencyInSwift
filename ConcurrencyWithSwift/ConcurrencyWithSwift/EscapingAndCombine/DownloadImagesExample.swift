//
//  DownloadImagesExample.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//


import SwiftUI
import Combine
/**
 Here we will showcase the difference in concurrency with combine and escaping vs.
 using async and await to download an image.
 
 We need a datamanager and view model like we used for do catch.
 */

struct DownloadImagesExample: View {
    
    // view model instance
    @StateObject private var viewModel = DownloadViewModel()
    
    
    var body: some View {
        
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct DownloadImagesExample_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImagesExample()
    }
}
