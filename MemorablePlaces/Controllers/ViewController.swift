//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by mostafa on 11/12/18.
//  Copyright © 2018 mostafa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController{
    
    
    let locationmanager = CLLocationManager()
    var annotation:MKAnnotation!
    var AnnotationTitle:String?
    var TackPlaceInfo:Dictionary<String,String>?
    var aNN:String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MapVC = segue.destination as! PlacesVC
        if let placename=TackPlaceInfo{
            print("Ann Bind")
            print(placename)
            MapVC.name=placename
            print(MapVC.name!,"name")
        }
    }
   
    var placeMark: CLPlacemark?
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationmanager.delegate = self
        locationmanager.requestAlwaysAuthorization()
        dropPin()
        
        
    }



}
extension ViewController:MKMapViewDelegate{
    
    func dropPin()  {
    let TouchPoint = UILongPressGestureRecognizer(target: self, action:#selector(AddAnotation(TapOnTheMap:)))
    MapView.addGestureRecognizer(TouchPoint)
    }
 
    }

extension ViewController:CLLocationManagerDelegate{
    
    
    @objc func AddAnotation(TapOnTheMap:UIGestureRecognizer){
        let geoCoder = CLGeocoder()
        let Point = TapOnTheMap.location(in: MapView)
        let Coordinate = MapView.convert(Point, toCoordinateFrom: MapView)
        let Location = CLLocation(latitude: Coordinate.latitude, longitude: Coordinate.longitude)
        geoCoder.reverseGeocodeLocation(Location) { (placemarks, error) in
            self.placeMark = placemarks?[0]
            if let locationmark = self.placeMark?.addressDictionary!["Name"]{
                
                self.AnnotationTitle = locationmark as! String
                
            }
        }
        
        let Annotation = MKPointAnnotation()
        Annotation.coordinate = Coordinate
        if let annotation = AnnotationTitle {
            aNN = annotation
            TackPlaceInfo = ["Name":"\(annotation)    \(Coordinate.latitude),\(Coordinate.longitude)"]
     Annotation.title = annotation
            MapView.addAnnotation(Annotation)
            
        }
        else {
            return
            
        }
        
        
        
        
    }
        
}


    
    
    
    

    
    


