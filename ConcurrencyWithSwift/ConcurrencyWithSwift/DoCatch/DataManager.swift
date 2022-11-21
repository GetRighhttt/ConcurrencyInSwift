//
//  DataManager.swift
//  ConcurrencyWithSwift
//
//  Created by Stefan Bayne on 11/21/22.
//

import Foundation


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
