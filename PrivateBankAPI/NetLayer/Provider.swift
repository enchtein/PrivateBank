//
//  Provider.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import Foundation
import PromiseKit
import Moya


struct Provider {
    static private let provider = MoyaProvider<RequestType>()
    
    static func requestToday() -> Promise<CurrensyExchange> {
        return Promise { seal in
            provider.request(.today) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let resp = try JSONDecoder().decode(CurrensyExchange.self, from: moyaResponse.data)
                        seal.fulfill(resp)
                    } catch let error {
                        seal.reject(error)
                    }
                // you can also have some logic and call reject() here
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
    static func requestByDate(date: Date) -> Promise<CurrensyExchange> {
        return Promise { seal in
            provider.request(.byDate(date: date)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let resp = try JSONDecoder().decode(CurrensyExchange.self, from: moyaResponse.data)
                        seal.fulfill(resp)
                    } catch let error {
                        seal.reject(error)
                    }
                // you can also have some logic and call reject() here
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
}

