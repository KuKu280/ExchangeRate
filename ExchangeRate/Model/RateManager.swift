//
//  RateManager.swift
//  ExchangeRate
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol RateManagerDelegate {
    func didUpdateRate(rates:String,currency:String)
    func didFailWithError(error:Error)
}

struct RateManager{
    
    
    var delegate:RateManagerDelegate?
    
    let baseURL = "https://forex.cbm.gov.mm"
    
    
    let currencyArray = ["USD","NPR","ZAR","CNY","CHF","THB","PKR","KES","EGP","EGP","SAR","LAK","SGD","IDR","KHR","LKR","NZD","CZK","JPY","VND","PHP","KRW","HKD","BRL","RSD","MYR","CAD","GBP","SEK","NOK","ILS","DKK","AUD","RUB","KWD","INR","BND","EUR"]
    
    func getRatePrice(for currency:String){
        let urlString = baseURL + "/api/latest"
        print(urlString)
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let exchageRate = self.parseJSON(safeData) {
                        let rateString = exchageRate[currency]!
                        self.delegate?.didUpdateRate(rates: rateString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data:Data)->[String:String]?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(RateData.self, from: data)
            let lastPrice = decodeData.rates
            return lastPrice
        }catch{
            delegate?.didFailWithError(error: error)
            
        }
        return nil
    }
    
    
    
    
}
