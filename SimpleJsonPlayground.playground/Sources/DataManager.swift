import Foundation

public class DataManager {
    
    public class func getData(byName: String) -> Data {
        let filePath = Bundle.main.path(forResource: byName, ofType:"json")
        let data = try! NSData(contentsOfFile: filePath!,
                               options: [])
        return data as Data
    }
    
    public class func loadDataFromURL(url: NSURL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
    
        let loadDataTask = session.dataTask(with: url as URL) { (data, response, error) -> Void in
          if let responseError = error {
            completion(nil, responseError as NSError?)
          } else if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
              let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
              completion(nil, statusError)
            } else {
              completion(data as NSData?, nil)
            }
          }
        }
        
        loadDataTask.resume()
      }
    
}
