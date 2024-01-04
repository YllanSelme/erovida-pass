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
