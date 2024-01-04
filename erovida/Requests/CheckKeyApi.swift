import Foundation
import SwiftUI

func checkKey(hashedKey: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "http://192.168.1.37:5000/check_key")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue(hashedKey, forHTTPHeaderField: "hashedKey")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let success = handleResponseCheck(data, response: response, error: error)
        completion(success)
        guard error == nil else {
            print("--> error: \(error!)")
            return
        }
    }
    task.resume()
}

func handleResponseCheck(_ data: Data?, response: URLResponse?, error: Error?) -> Bool {
    if let error = error {
        print("Error: \(error)")
        return false
    }

    guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid HTTP response")
        return false
    }

    if !(200..<300).contains(httpResponse.statusCode) {
        print("HTTP Error: \(httpResponse.statusCode)")
        return false
    }

    guard let data = data else {
        print("Empty data")
        return false
    }

    do {
        if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
            if contentType.lowercased().contains("application/json") {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                print("\n---> response: " + String(decoding: jsonData, as: UTF8.self))
                // Adjust the logic based on your server response format
                // Return true or false based on the server response
                return true
            } else {
                let responseString = String(data: data, encoding: .utf8)
                print("\n---> response: \(responseString ?? "Unable to decode non-JSON response")")
                // Adjust the logic based on your server response format
                // Return true or false based on the server response
                return true
            }
        }
    } catch {
        print("Error decoding JSON: \(error)")
    }

    return false
}
