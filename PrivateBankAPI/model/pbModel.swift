//
//  pbModel.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import Foundation

struct CurrensyExchange: Codable {
    var date: String
    var bank: String
    var baseCurrency: Int
//    var baseCurrensyLit: String
    var baseCurrencyLit: BaseCurrency
    var exchangeRate: [ExchangeRate]
}

enum BaseCurrency: String, Codable {
    case uah = "UAH"
}
struct ExchangeRate: Codable {
//    var baseCurrency: String
    var baseCurrency: BaseCurrency
    var currency: String?
    var saleRateNB: Double
    var purchaseRateNB: Double
    var saleRate: Double?
    var purchaseRate: Double?
}
