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
class MapViewController: UIViewController{
    
    
    let locationmanager = CLLocationManager()
    var annotation:MKAnnotation!
    var AnnotationTitle:String?
    var long:Double?
    var lat:Double?
    var recievelong:Double?
    var recievelat:Double?
    var TackPlaceInfo:Dictionary<String,String>?
    var SavedAnnotation:CLLocationCoordinate2D?
    var DropAnn:CLLocationCoordinate2D?
    func PinSavedAnn(longtude:Double,latitude:Double){
        let Annotation = MKPointAnnotation()
        let AnnotationCoord = CLLocationCoordinate2D(latitude:CLLocationDegrees(latitude), longitude:CLLocationDegrees(longtude))
        Annotation.coordinate = AnnotationCoord
        MapView.addAnnotation(Annotation)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UNWIND{
        let PlacesVC = segue.destination as! PlacesVC
        if let placename=TackPlaceInfo{
            print(placename)
            PlacesVC.name=placename
            print(PlacesVC.name!,"name")
            }
            if let Savelongtude=long {PlacesVC.SaveLong = Savelongtude }
            if let Savelatitude = lat {PlacesVC.SaveLat = Savelatitude}
            
//355431074093129
            
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
    override func viewDidAppear(_ animated: Bool) {
        if let Long = recievelong{
            if let Lat = recievelat{
            PinSavedAnn(longtude: Long, latitude: Lat)
            }}
        
    }



}
extension MapViewController:MKMapViewDelegate{
    
    func dropPin()  {
    let TouchPoint = UILongPressGestureRecognizer(target: self, action:#selector(AddAnotation(TapOnTheMap:)))
    MapView.addGestureRecognizer(TouchPoint)
    }
 
    }

extension MapViewController:CLLocationManagerDelegate{
    
    
    @objc func AddAnotation(TapOnTheMap:UIGestureRecognizer){
        if TapOnTheMap.state==UIGestureRecognizerState.began{
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
        SavedAnnotation = Coordinate
        long = Coordinate.longitude
        lat = Coordinate.latitude
        print(lat,long)
        if let annotation = AnnotationTitle {
            TackPlaceInfo = ["Name":annotation]
        MapView.addAnnotation(Annotation)
            performSegue(withIdentifier: UNWIND, sender: self)
        }
        else {
            return
            
        }
        
        
        }
        
    }
        
}


    
    
    
    

    
    


