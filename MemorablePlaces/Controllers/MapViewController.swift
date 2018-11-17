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
    var TackPlaceInfo:Dictionary<String,String>?
    var SavedAnnotation:CLLocationCoordinate2D?
    var DropAnn:CLLocationCoordinate2D?
    func PinSaveAnnotation(DropAnnotation:CLLocationCoordinate2D) {
        let Annotation=MKPointAnnotation()
        Annotation.coordinate = DropAnnotation
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
            if let SavedAnn=SavedAnnotation {PlacesVC.SavedAnnotation=SavedAnn}

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
        if let Dropann = DropAnn{
            PinSaveAnnotation(DropAnnotation: Dropann)
            print(Dropann)
        }    }



}
extension MapViewController:MKMapViewDelegate{
    
    func dropPin()  {
    let TouchPoint = UILongPressGestureRecognizer(target: self, action:#selector(AddAnotation(TapOnTheMap:)))
    MapView.addGestureRecognizer(TouchPoint)
    }
 
    }

extension MapViewController:CLLocationManagerDelegate{
    
    
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
        SavedAnnotation = Coordinate
        if let annotation = AnnotationTitle {
            TackPlaceInfo = ["Name":"\(annotation)    \(Coordinate.latitude),\(Coordinate.longitude)"]
        Annotation.title = annotation
        MapView.addAnnotation(Annotation)
            
        }
        else {
            return
            
        }
        
        
        
        
    }
        
}


    
    
    
    

    
    


