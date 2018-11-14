//
//  PlacesVC.swift
//  MemorablePlaces
//
//  Created by mostafa on 11/12/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit


class PlacesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ArrayofPlaces = [Dictionary<String,String>]()
    var name:Dictionary<String,String>?
    var Name:Dictionary<String,String>?
    @IBAction func UnWindToPlacesVC(_ sender:UIStoryboardSegue){}
    
    @IBOutlet weak var TableView: UITableView!
    func takeit(Name:Dictionary<String,String>){
       ArrayofPlaces.append(Name)
        
    }
    @IBAction func AddPlace(_ sender: Any) {
        performSegue(withIdentifier: TOMAP, sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.delegate = self
        TableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if let names = name{
            takeit(Name: names)
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
    }
    
    

