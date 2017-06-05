//
//  CityManager.swift
//  WeatherApp
//
//  Created by Misayel Gezahen on 6/1/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import CoreData

class CityManager {
    
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    class func allCities() -> [City]{
        
        guard let viewContext = appDelegate?.persistentContainer.viewContext else {
            return []
        }
        
        //search for cities alphabetically
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
        let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            //try to fetch all cities
            let results = try viewContext.fetch(fetchRequest)
            
            //cast the results to a list of Managed Objects
            guard let cities = results as? [NSManagedObject] else {
                return []
            }
            
            //try to convert each Managed Object to our custom City class
            var output: [City] = []
            for obj in cities {
                
                guard let name = obj.value(forKey: "name") as? String else{
                    continue
                }
                
                //add the city to the result set
                let city = City(name: name)
                output.append(city)
            }
            return output
            
        }catch let error as NSError {
            //error retrieving cities 
            
            print(error)
            return []
        }
    }
    
    class func saveCity(name: String){
        
        guard let viewContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        //add city
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: viewContext) else {
            return
        }
        
        let city = NSManagedObject(entity: entity, insertInto: viewContext)
        city.setValue(name, forKey: "name")
        
        do {
            try viewContext.save()
        }catch{
            print("Could not save city \(name)")
        }
    }

}
