//
//  PlacesVC.swift
//  MemorablePlaces
//
//  Created by mostafa on 11/12/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import MapKit


class PlacesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func AddPlace(_ sender: Any) {
        performSegue(withIdentifier: ADDSEGUE, sender: self)
    }
    
    var ArrayofPlaces = [Dictionary<String,String>]()
    var name:Dictionary<String,String>?
    var Name:Dictionary<String,String>?
    var SaveLong:Double?
    var SaveLat:Double?
    var counter:Int=0
    var Longarray = [Double]()
    var Latarray = [Double]()
    
    @IBOutlet weak var TableView: UITableView!
    @IBAction func UnWindToPlacesVC(_ sender:UIStoryboardSegue){}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOMAP{
            
            let MapVC = segue.destination as! MapViewController
            if let sendlong = SaveLong{MapVC.recievelong = sendlong}
            if let sendlat = SaveLat{MapVC.recievelat = sendlat}
        
        }}
    
        func takeit(Name:Dictionary<String,String>,Longtude:Double,Latitude:Double){
            for places in 0..<ArrayofPlaces.count{
                
            if Name["Name"] == ArrayofPlaces[places]["Name"] {
                counter+=1
                }
            }
            if counter==0
            { ArrayofPlaces.append(Name)
                
                // UserDefaults.standard.set(ArrayofPlaces, forKey: "array")
                
            }
                Longarray.append(Longtude)
                Latarray.append(Latitude)
    }
    
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        
        if let names = name {
            if let savlat = SaveLat {
                if let savlong = SaveLong{
            takeit(Name: names, Longtude: savlong, Latitude: savlat)
                }}}
        TableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ArrayofPlaces.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            ArrayofPlaces.remove(at: indexPath.row)
       
            TableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var Cell = UITableViewCell()
        Cell = TableView.dequeueReusableCell(withIdentifier: PLACES, for: indexPath)
        
       Cell.textLabel?.text=ArrayofPlaces[indexPath.row]["Name"]
            Cell.textLabel?.font = UIFont(name: "Avenir Next", size: 15)
        
        return Cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SaveLat = Latarray[indexPath.row]
        SaveLong = Longarray[indexPath.row]
        
        performSegue(withIdentifier: TOMAP, sender: self)
    }
    }
    


