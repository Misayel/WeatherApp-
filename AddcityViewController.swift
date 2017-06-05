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

class AddcityViewController: UIViewController {
    
    
    
    var delegate: AddCityDelegate?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let task = Task(context: context) // Link Task & Context
    task.name = CityTextField.text!
    
    // Save the data to coredata
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    
    
    
    guard let city = CityTextField.text else {
    return
    }
    delegate?.CityAdded(city: city )
    let _ = navigationController?.popViewController(animated:true)
    
}
}
