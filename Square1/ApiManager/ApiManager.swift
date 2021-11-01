//
//  ApiManager.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    let baseURL = "connect-demo.mobile1.io/square1/connect/v1"
    
    private let session = URLSession(configuration: .default)
    
    func listCities(page:Int?,filter:String?,include_country:Bool = false,completion: @escaping (Result<JsonData,ErrorModel>)-> Void) {
        let listCitiesRequest = ListCitiesRequest(baseUrl: baseURL, page: page, filter: filter, include_country: include_country)
        self.apiRequest(request: listCitiesRequest,completion: completion)
    }
    
    
    private func apiRequest<T: Decodable, I: APIRequest>(request: I, completion: @escaping (Result<T, ErrorModel>)-> Void){
        print(request.urlRequest!)
        let task = session.dataTask(with: request.urlRequest!) { data, response, error in
            if let error = error {
                let errorModel = ErrorModel(status: "", timeStamp: "", code: 0, message: error.localizedDescription)
                completion(.failure(errorModel))
                
            }else if let data = data {
                do {
                    let code = (response as! HTTPURLResponse).statusCode
                    print(code)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                   print(json)
                    if(code == 200) {
                        let decodeResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodeResponse))
                    }else{
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                            let decodeResponse = try decoder.decode(ErrorModel.self, from: data)
                            
                            completion(.failure(decodeResponse))
                        } catch let e{
                            let error = ErrorModel(status: "", timeStamp: "", code: 0, message: e.localizedDescription)
                            completion(.failure(error))
                        }
                    }
                } catch let e {
                    do {
                        let decodeResponse = try JSONDecoder().decode(ErrorModel.self, from: e as! Data)
                        completion(.failure(decodeResponse))
                    } catch {
                        let error = ErrorModel(status: "", timeStamp: "", code: 0, message: e.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
        
    }
}
    
    

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
