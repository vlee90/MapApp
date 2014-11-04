//
//  RegionViewController.swift
//  MapApp
//
//  Created by Vincent Lee on 11/3/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit
import MapKit

class RegionViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var selectedAnnotation: MKAnnotation!
    var geoRegion: CLCircularRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier = "REGION"
        self.geoRegion = CLCircularRegion(center: selectedAnnotation.coordinate, radius: 100.0, identifier: identifier)
        var camera = MKMapCamera()
        camera.centerCoordinate = selectedAnnotation.coordinate
        self.mapView.camera = camera
        self.mapView.addAnnotation(self.selectedAnnotation)
        self.setOverlay()
    }


    @IBAction func buttonPressed(sender: AnyObject) {
        self.locationManager.startMonitoringForRegion(geoRegion)
        NSNotificationCenter.defaultCenter().postNotificationName("REMINDER_ADDED", object: self, userInfo: ["region" : geoRegion])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setOverlay() {
        let overlay = MKCircle(centerCoordinate: self.geoRegion.center, radius: self.geoRegion.radius)
        self.mapView.addOverlay(overlay)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.greenColor().colorWithAlphaComponent(0.20)
        renderer.strokeColor = UIColor.greenColor()
        renderer.lineWidth = 1.0
        return renderer
    }
    
}
