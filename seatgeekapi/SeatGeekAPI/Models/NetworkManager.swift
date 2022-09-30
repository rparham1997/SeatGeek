//
//  NetworkManager.swift
//  SeatGeekAPI
//
//  Created by J.A. Ramirez on 1/6/21.
//

import Foundation

struct NetworkManager {
    
    // Pre-processor Directives - the compiler sees this.
    // If Xcode is running in DEBUG mode, it will run this code.
    #if DEBUG
    let clientId = "MjE0ODE2MTV8MTYwOTk4NDIwMi43MjMwOTk3"
    #else
    // Production code is Release configuration, and it's the customer ready app version.
    // Use production client id. This is ignored if creating in DEBUG mode.
    let clientId = ""
    #endif
    
    let secret = "4440f274150a8c21fd7be851ea29c8cd1451944d57ec113bc9d8379abb6d189a"
    
    // Create the valid url to use for the session.
    private func prepareEndpoint(with query: String) -> String {
        return "https://api.seatgeek.com/2/events?client_id=\(clientId)&q=\(query)"
    }
    
    // Call the endpoint to get the data back.
    func searchEvents(with query: String, completionHander: @escaping (Bool, String) -> Void) {
        
        // First, create a valid URl from the API endpoint.
        guard let url = URL(string: prepareEndpoint(with: query)) else {
            // You should use this to test for developer errors.
            print("Invalid URL request.")
            completionHander(false, "")
            return
        }
        
        // Create a data task to actually fetch the data from the URL.
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            
            // If there is an error, then exit.
            if error != nil {
                // There was an error, let the user know.
                print("There was an error: \(error?.localizedDescription ?? "")")
                completionHander(false, "")
                return
            }
            
            // Check that data is not nil.
            guard let validData = data else {
                print("Error, data was nil.")
                completionHander(false, "")
                return
            }
            
            // The "response" object contains HTTP status code and headers. These might be important depending on the API.
            
            // We need to convert the data into readable information. Convert the validData to a json object.
            // Then, convert the json object into pretty printed data format (for easy readability).
            // Now that it's converted into readable data object, convert the jsonData back to string.
            if let object = try? JSONSerialization.jsonObject(with: validData, options: []),
               let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
               let str = String(data: jsonData, encoding: String.Encoding.utf8) {
                completionHander(true, str)
            } else {
                print("Error converting data to JSON dictionary.")
                completionHander(false, "")
            }
        }
        
        // Triggers the actual network call.
        dataTask.resume()
    }
}
