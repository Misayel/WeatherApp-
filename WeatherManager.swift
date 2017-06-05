//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Misayel Gezahegnon 6/2/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



struct Forecast {
    
    let tempC: Double
    let tempF: Double
    let text: String
    let iconURL: String
}

struct WeatherEndpoint {
    
    static let base = "https://api.apixu.com/v1/current.json?key=636b1cc4d5ce4f489db213542162011"
    
    static func currentForecast(city: City) -> String? {
        
        guard let encodedCity = city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return nil
        }

        return base + "&q=" + encodedCity
    }
}

class WeatherManager {
    
    class func getCurrentWeather(city: City, completion: @escaping (Forecast?)->Void){
     
        guard let url = WeatherEndpoint.currentForecast(city: city) else {
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            
            guard let res = response.result.value else{
                return
            }
         
            let json = JSON(res)
            
            guard let tempC = json["current"]["temp_c"].double,
               let tempF = json["current"]["temp_f"].double,
               let text = json["current"]["condition"]["text"].string,
               let icon = json["current"]["condition"]["icon"].string else {
            
                completion(nil)
                return
            }
            
            let forecast = Forecast(tempC: tempC, tempF: tempF, text: text, iconURL: icon)
            completion(forecast)
        }
    }
}
