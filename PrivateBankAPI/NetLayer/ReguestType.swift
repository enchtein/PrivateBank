//
//  ReguestType.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import Foundation
import Moya

enum RequestType {
    case today
    case byDate(date: Date)
}

extension RequestType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.privatbank.ua/")!
    }
    
    var path: String {
        switch self {
        case .today:
            return "p24api/exchange_rates"
        case .byDate(_):
            return "p24api/exchange_rates"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let tempDate = Date()
        let today = dateFormatter.string(from: tempDate)
        
        var parameters = [String:Any]()
        parameters["json"] = ""
        switch self {
        case .today:
            parameters["date"] = today
//            parameters["date"] = "21.02.2021"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .byDate(let date):
            let selectedDay = dateFormatter.string(from: date)
            parameters["date"] = selectedDay
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
