//
//  NetworkSessionManager.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 03/08/2022.
//

import Foundation

final class NetworkSessionManager {
    
    static let shared = NetworkSessionManager()
    let session = URLSession.shared
    
    
    private init() {
        
    }
    
    public func sendHttpRequest(onMainThread: Bool, to urlString: String, completion:@escaping (Result<Data, HTTPRequestError>)-> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrlError(withError: "[Request Error] Unable to create url from: \(urlString) string")))
            return
        }
        let queue = onMainThread ? DispatchQueue.main : DispatchQueue.global(qos: .background)
        
        queue.async { [weak self] in
            
            guard let task = self?.session.dataTask(with: url, completionHandler: { data, response, error in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.unknownError(withError: "[Request Error] Unable to get status code from http response")))
                    return
                }
                
                if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                    guard let data = data else {
                        completion(.failure(.unknownError(withError: "[Request Error] Unable to get data from http response")))
                        return
                    }
                    
                    completion(.success(data))
                    return
                    
                }else {
                    completion(.failure(.requestFailedError(withError: "[Request Error] Request failed with status http status code \(httpResponse.statusCode)")))
                    return
                }
                
            }) else {
                completion(.failure(.unknownError(withError: "[Request Error] Current task is nil")))
                return
            }
            task.resume()
            
        }
        
//        return .success(Data())
    }
    
    
    
}


public enum HTTPRequestError: Error {
    case requestFailedError(withError: String)
    case invalidUrlError(withError: String)
    case jsonDecodingError(withError: String)
    case imageDataDecodingError(withError: String)
    case unknownError(withError: String)
}






