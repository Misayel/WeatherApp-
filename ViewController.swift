//
//  ViewController.swift
//  WeatherApp
//
//  Created by Misayel Gezahegn on 5/31/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddCityDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cities = CityManager.allCities()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        //cell.textLabel?.text = cities[indexPath.row] - old way, with array of strings
        cell.textLabel?.text = cities[indexPath.row].name //new way, with array of Cities
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    //delegate function
    func CityAdded(city: String) {
        //cities.append(city)
        
        cities = CityManager.allCities()
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let id = segue.identifier else {
            return
        }
        
        if (id == "AddCitySegue"){
        
            guard let vc = segue.destination as? AddCityViewController else {
                return
            }
            vc.delegate = self
            
        }else if (id == "WeatherSegue"){
            
            guard let vc = segue.destination as? WeatherViewController else {
                return
            }
            
            guard let row = tableView.indexPathForSelectedRow?.row else {
                return
            }
            
            vc.city = cities[row]
        }
    }
}
