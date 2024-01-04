import Foundation

func performHTTPRequest(urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NSError(domain: "Invalid HTTP Response", code: 0, userInfo: nil)))
            return
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
            return
        }

        guard let responseData = data else {
            completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
            return
        }

        if let responseString = String(data: responseData, encoding: .utf8) {
            completion(.success(responseString))
        } else {
            completion(.failure(NSError(domain: "Invalid Data", code: 0, userInfo: nil)))
        }
    }

    task.resume()
}


func createAccount(hashedKey: String, nameCipher: String, nameNonce: String, nameTag: String, lastNameCipher: String, lastNameNonce: String, lastNameTag: String) {
    let url = URL(string: "http://192.168.1.37:5000/create_account")!


    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue(hashedKey, forHTTPHeaderField: "hashedKey")
    request.addValue(nameCipher, forHTTPHeaderField: "nameCipher")
    request.addValue(nameNonce, forHTTPHeaderField: "nameNonce")
    request.addValue(nameTag, forHTTPHeaderField: "nameTag")
    request.addValue(lastNameCipher, forHTTPHeaderField: "lastNameCipher")
    request.addValue(lastNameNonce, forHTTPHeaderField: "lastNameNonce")
    request.addValue(lastNameTag, forHTTPHeaderField: "lastNameTag")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        showResponse(data, response: response, error: error)
        guard error == nil else {
            print("--> error: \(error!)")
            return
        }
    }
    task.resume()
}

func showResponse(_ data: Data?, response: URLResponse?, error: Error?) {
    if let error = error {
        print("Error: \(error)")
        return
    }

    guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid HTTP response")
        return
    }

    if !(200..<300).contains(httpResponse.statusCode) {
        print("HTTP Error: \(httpResponse.statusCode)")
        return
    }

    guard let data = data else {
        print("Empty data")
        return
    }

    do {
        if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
            if contentType.lowercased().contains("application/json") {
                // Try to decode as JSON
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                print("\n---> response: " + String(decoding: jsonData, as: UTF8.self))
            } else {
                // Not JSON, print as plain text
                let responseString = String(data: data, encoding: .utf8)
                print("\n---> response: \(responseString ?? "Unable to decode non-JSON response")")
            }
        }
    } catch {
        print("Error decoding JSON: \(error)")
    }
}
