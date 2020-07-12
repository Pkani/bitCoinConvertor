//
//  ViewController.swift
//  bitCoinPriceConvertor
//
//  Created by Artixun on 7/4/20.
//  Copyright © 2020 Pk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var COINDESK_URL = "https://api.coindesk.com/v1/bpi/currentprice/EUR.json"
    
    var pickerData: [String] = [String]()
    var bitcoinResult : String?
    var selectedRow: String = "EUR"

    
    @IBOutlet weak var bitcoinImage: UIImageView!
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        
        
        //bitcoinPriceFatch(url: COINDESK_URL, currency: selectedRow!)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPicker()
        updateUI()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bitcoinPriceFatch(url: String, currency: String) -> Void {
        // let currency = "INR"
        //let currency = pickerView(UIPickerView, didSelectRow: Int, inComponent: Int)
        

        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("you got it!")
                
                let bitcoinJSON: JSON = JSON(response.result.value!)
                self.bitcoinLabel.text = bitcoinJSON["bpi"]["\(currency)"]["rate"].string
                
                print(bitcoinJSON)
            }
            else {
                print("Error \(response.result.error)")
            }
            //debugPrint(response)
        }
    }
    
    func updateBitcoinPrice(json: JSON) {
        
        //bitcoinResult = json["bpi"]["USD"].string
        
        //print(bitcoinResult!)
    }
    

    
    func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        pickerData = ["INR", "USD", "CNY", "EUR", "JPY", "AUD", "CAD", "ZND"]
    }
    //var selectedValue = pickerViewContent[pickerView.selectedRowInComponent(0)]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //let selectedRow = pickerData[row] as String
        //print(selectedRow)
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = pickerData[row] as String
        print(selectedRow)
//        bitcoinResult = selectedRow
//        print(bitcoinResult)
        
        if selectedRow != "USD"{
            COINDESK_URL = "https://api.coindesk.com/v1/bpi/currentprice/\(selectedRow).json"
            // "https://api.coindesk.com/v1/bpi/currentprice/\(bitcoinResult ?? "USD").json"
        }
        else {
            COINDESK_URL = "https://api.coindesk.com/v1/bpi/currentprice/USD.json"
        }
        updateUI()
    }
    func updateUI() -> Void {
        setupPicker()
        bitcoinPriceFatch(url: COINDESK_URL, currency: selectedRow)
    }


}

