import Foundation

func requestMain( urlStr: String,
                  jsonBody: [ String: Any ] ) -> [ String: Any ] {
    
    let returnError: [String: Bool] = ["status": false]
    
    guard let url = URL( string: urlStr ) else { return returnError }
    
    var request = URLRequest( url: url )
    request.httpMethod = "POST"
    request.addValue( "application/json",
                      forHTTPHeaderField: "Content-Type" )
    
    guard let httpBody = try?
        JSONSerialization.data( withJSONObject: jsonBody, options: [] ) else { return returnError }
    
    request.httpBody = httpBody
    
    let semaphore = DispatchSemaphore(value: 0)
    
    var returnJson: [String: Any] = [:]
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        
        if let response = response {
            print(response)
        }
        guard let data = data else { return }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                returnJson = json
            }
            semaphore.signal()
            
        } catch {
            print(error)
        }
        
    }.resume()
    
    semaphore.wait()
    
    return returnJson;
    
}
