import Foundation

func requestMain( urlStr: String,
                  jsonBody: [String: Any],
                  finished: @escaping ( ([String: Any]) -> Void ) ) {
    
    guard let url = URL( string: urlStr ) else { return }

    var request = URLRequest( url: url )
    request.httpMethod = "POST"
    request.addValue( "application/json",
                      forHTTPHeaderField: "Content-Type" )
    
    guard let httpBody = try?
        JSONSerialization.data( withJSONObject: jsonBody, options: [] ) else { return }
    
    request.httpBody = httpBody
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        guard let data = data else { return }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                finished( json )
            }
            semaphore.signal()
            
        } catch {
            print(error)
        }
        print("ya tut")
        
    }.resume()
    
    semaphore.wait()
    
}
