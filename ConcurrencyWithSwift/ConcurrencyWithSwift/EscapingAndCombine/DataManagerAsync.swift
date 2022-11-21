//
//  DataManagerAsync.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import Foundation
import Combine
import UIKit


/**
 Here is the source of truth for our data. This acts like a data source(api, server, etc.)
 */

class DataManager {
    
    let url = URL(string: "https://picsum.photos/200")! // unwrapping not safe here...
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    /**
     This is the first example with a completion handler and @escaping keyword. This is how we used to make httprequests.
     URLSessions calls the data when its called and the completion handler executes after it gets returned.
     
     URLSessions run on a background thread and we need to switch back to the main thread to avoid erros.
     
     The completion handler cannot be used outside of the function so we use the @escaping keyword so it allows it to do so.
     */
    func downloadWithEscaping(completionHandler: @escaping(_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
            
        }.resume()
    }
    
    /**
     Here we use combine and show how we can retrieve data this way.
     */
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    /**
     Here is the new way of making requests that works better and faster!
     */
    func downloadWithAsyncAwait() async throws -> UIImage? {
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
            
        }catch {
            
            throw error
        }
    }
}
