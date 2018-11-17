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
    
    var ArrayofPlaces = [Dictionary<String,String>]()
    var ArrayofPlaces2 = [Dictionary<String,String>]()
    var name:Dictionary<String,String>?
    var Name:Dictionary<String,String>?
    var savedAnnotation=[CLLocationCoordinate2D]()
    var DropAnnottion:CLLocationCoordinate2D?
    var SavedAnnotation:CLLocationCoordinate2D?
    @IBAction func UnWindToPlacesVC(_ sender:UIStoryboardSegue){}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOMAP{
            
            let MapVC = segue.destination as! MapViewController
            if let saveannotation = DropAnnottion{MapVC.DropAnn = saveannotation}
        }
    }
    
    @IBOutlet weak var TableView: UITableView!
    func takeit(Name:Dictionary<String,String>,Annotation:CLLocationCoordinate2D){
       ArrayofPlaces.append(Name)
        UserDefaults.standard.set(ArrayofPlaces, forKey: "array")
        savedAnnotation.append(Annotation)

        
    }
    @IBAction func AddPlace(_ sender: Any) {
        performSegue(withIdentifier: ADDSEGUE, sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let arr = UserDefaults.standard.object(forKey: "array")as? [Dictionary<String,String>]{
ArrayofPlaces2=arr
        }
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let tempplaces = UserDefaults.standard.object(forKey: "array") as? [Dictionary<String,String>] {
            ArrayofPlaces = tempplaces
        }
        if let names = name{
            takeit(Name: names, Annotation: SavedAnnotation!)
            print(names)
        }
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ArrayofPlaces.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArrayofPlaces.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var Cell = UITableViewCell()
        Cell = TableView.dequeueReusableCell(withIdentifier: PLACES, for: indexPath)
        
        
            Cell.textLabel?.text=ArrayofPlaces[indexPath.row]["Name"]
            Cell.textLabel?.font = UIFont(name: "Avenir Next", size: 15)
        
    
        
    
        return Cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DropAnnottion = savedAnnotation[indexPath.row]
        performSegue(withIdentifier: TOMAP, sender: self)
    }
    }
    
    

