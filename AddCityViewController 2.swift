//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Misayel Gezahegn on 5/31/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

protocol AddCityDelegate {
    
    func CityAdded(city:String)
}

// prtocol AddCityDelegate will be a protocol to add simply city in our WeatherApp.

class AddCityViewController: UIViewController {
    
// AddCityViewController class of UIViewController.add
    
    @IBOutlet weak var CityTextField: UITextField!
    var delegate: AddCityDelegate?
    
// City textField.TextField to add a text letter from UI interface/Main Storyboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func CityAdded(_ sender: Any) {

        
        guard let city = CityTextField.text else {
            return
        }
// Guard statement to only accept text information else return as error or empty.
        
        //save the city to Core Data
        CityManager.saveCity(name: city)
    
        delegate?.CityAdded(city: city )
        let _ = navigationController?.popViewController(animated:true)
    }
}
