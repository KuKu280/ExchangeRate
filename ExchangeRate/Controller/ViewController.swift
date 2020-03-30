//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rateLabel: UILabel!
        
    @IBOutlet weak var currencyLabel: UILabel!
        
    @IBOutlet weak var currencyPicker: UIPickerView!
        
    @IBOutlet weak var exchangeview: UIView!
        
       
        var rateManager = RateManager()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            rateManager.delegate = self
            currencyPicker.delegate = self
            currencyPicker.dataSource = self
            
            exchangeview.layer.cornerRadius = 20
            exchangeview.layer.borderWidth = 3.0
            exchangeview.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        }
        

    }

    //MARK: - RateManagerDelegate
    extension ViewController:RateManagerDelegate{
        
        func didUpdateRate(rates: String, currency: String) {
            DispatchQueue.main.sync {
                self.currencyLabel.text = currency
                self.rateLabel.text = rates
            }
        }
        
        func didFailWithError(error: Error) {
            print(error)
        }
        
        
    }

    //MARK: - UIPickerDelegate
    extension ViewController:UIPickerViewDataSource,UIPickerViewDelegate{
        

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return rateManager.currencyArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return rateManager.currencyArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCurrency = rateManager.currencyArray[row]
            rateManager.getRatePrice(for: selectedCurrency)
        }


}

