//
//  RepositoryController.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 08.01.23.
//

import Foundation
import RxSwift

final class RepositoryController {
    
    struct Constants {
        static let EMAIL: String = "email"
        static let PASSWORD: String = "password"
    }
    
    static func setUserDefaultsValue(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getUserDefaultsValue(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func fetchData(urlString: String) -> Observable<Any> {
        Observable.create { observable in
            guard let url = URL(string: urlString) else {return Disposables.create()}
            
            let request: URLRequest = URLRequest(url:url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            DispatchQueue.global(qos: .utility).async {
                let task = session.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        observable.onError(error)
                    }
                    do{
                        let jsonDict:NSDictionary = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary) ?? NSDictionary()
                        let data: [String: Any]? = jsonDict as? [String: Any]
                        observable.onNext(data)
                        
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                };
                task.resume()
            }
            return Disposables.create()
        }
    }
}
