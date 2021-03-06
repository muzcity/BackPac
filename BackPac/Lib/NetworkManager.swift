//
//  NetworkManager.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    let BASE_URL = "https://itunes.apple.com/search"
    
    func request(by keyword : String, country : String = "kr", media : String = "software") -> Observable< Result<Data, Error> > {
        
        let query = "?term=\(keyword)&country=\(country)&media=\(media)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = self.BASE_URL + query
        
        let ob = Observable< Result<Data, Error> >.create { [unowned self] (observer) -> Disposable in
            
            if let url = URL(string: urlString) {
                
                self.request(by: url, method: .get, params: nil, headers: nil) { (response) in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    default:
                        observer.onNext(.failure(response.error ?? RxError.unknown))
                        break
                    }
                }
                
            }
            
            return Disposables.create()
        }
        
        return ob
    }
    
    
    
    ///MARK: - 공통
    private func request(by url:URL, method:HTTPMethod, params:Parameters?, headers:HTTPHeaders?, completeHandler: @escaping ((AFDataResponse<Data>)->()) ) {
        
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseData { (response) in
            completeHandler( response )
        }
        
    }
}
