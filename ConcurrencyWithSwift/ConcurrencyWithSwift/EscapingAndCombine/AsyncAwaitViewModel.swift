//
//  ViewModel.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import Foundation
import Combine
import UIKit

class DownloadViewModel : ObservableObject {
    
    @Published var image: UIImage? = nil
    
    let loader = DataManager()
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() async {
        
        /*
         Escpaing and completion handler example:
         
         loader.downloadWithEscaping { [weak self] image, error in
         // switch back to main thread
         DispatchQueue.main.async{
         self?.image = image
         }
         }
         
         */
        
        /*
         Combine example:
         
         loader.downloadWithCombine()
         .receive(on: DispatchQueue.main)
         .sink{ _ in
         
         } receiveValue: { [weak self] image in
         self?.image = image
         }
         .store(in: &cancellables)
         */
        
        /*
         Async and Await Example: We use actors to switch between threads, and back
         to main thread!
         */
        let image = try? await loader.downloadWithAsyncAwait()
        await MainActor.run {
            self.image = image
        }
    }
}

