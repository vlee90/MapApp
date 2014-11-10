//
//  MapViewController.swift
//  MapApp
//
//  Created by Vincent Lee on 11/3/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var notification = UILocalNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reminderAdded:", name: "REMINDER_ADDED", object: nil)
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.authorization()
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "didLongPressOnMap:")
        self.mapView.addGestureRecognizer(longPress)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        self.notification.fireDate = nil
        self.notification.alertBody = "Entered region"
        self.notification.alertAction = "AlertAction"
        UIApplication.sharedApplication().presentLocalNotificationNow(self.notification)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.greenColor().colorWithAlphaComponent(0.20)
        renderer.strokeColor = UIColor.greenColor()
        renderer.lineWidth = 1.0
        return renderer
    }
    
    func reminderAdded(notification: NSNotification) {
        let geoRegion = notification.userInfo!["region"] as CLCircularRegion
        println(geoRegion.center.latitude)
        println(geoRegion.center.longitude)
        let overlay = MKCircle(centerCoordinate: geoRegion.center, radius: geoRegion.radius)
        self.mapView.addOverlay(overlay)
    }
    
    func authorization() {
        switch CLLocationManager.authorizationStatus() as CLAuthorizationStatus {
        case CLAuthorizationStatus.Authorized:
            println("Authorized")
            self.locationManager.startUpdatingLocation()
        case CLAuthorizationStatus.NotDetermined:
            println("User has not determined with location services will be used")
            self.locationManager.requestAlwaysAuthorization()
        case CLAuthorizationStatus.Restricted:
            println("Application is not authorized to use location services")
        case CLAuthorizationStatus.Denied:
            println("User has explicitly denied location services.")
        default:
            println("Unknown Error Occured")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.Authorized:
            println("Authorization changed to authorized")
        case CLAuthorizationStatus.NotDetermined:
            println("Authorization changed to not determined")
            self.locationManager.requestAlwaysAuthorization()
        case CLAuthorizationStatus.Restricted:
            println("Authorization changed to being restricted")
        case CLAuthorizationStatus.Denied:
            println("Authorization chaged to being denied by user")
        default:
            println("Authorization changed to an known status")
        }
    }
    
    func didLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let touchPoint = sender.locationInView(self.mapView)
            let touchCoordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            var annotation = MKPointAnnotation()
            annotation.title = "Reminder"
            annotation.subtitle = "Reminder Detail"
            annotation.coordinate = touchCoordinate
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "ANNOTATION"
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.animatesDrop = true
        annotationView.canShowCallout = true
        
        let button = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let identifier = "REGION_VC"
        let regionVC = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as RegionViewController
        regionVC.locationManager = self.locationManager
        regionVC.selectedAnnotation = view.annotation
        self.presentViewController(regionVC, animated: true, completion: nil)
    }
    
    
}
