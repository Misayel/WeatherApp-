//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Misayel Gezahegn on 6/1/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = city?.name ?? "Weather"
    
        updateForecast()
    }
    
    func updateForecast(){
        
        guard let c = city else {
            return
        }
        
        WeatherManager.getCurrentWeather(city: c, completion: { forecast in
            
            DispatchQueue.main.async {
                self.temperatureLabel.text = String(describing: forecast?.tempF ?? 0) 
            }
        })
        
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
