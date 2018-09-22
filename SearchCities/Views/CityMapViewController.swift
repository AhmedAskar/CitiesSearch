//
//  CityMapViewController.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/15/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: UIViewController {
    
    // MARK: Properities
    var viewModel: CityMapViewModel?
    
//    var city: City?
    private let locationManager = CLLocationManager()
    
    // MARK: - Outlets
    @IBOutlet public weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.cityMapLoadCompletion = { [weak self] in
            let coordinates = CLLocationCoordinate2D(latitude: self?.viewModel?.city?.coord.lat ?? 0.0, longitude: self?.viewModel?.city?.coord.lon ?? 0.0)
            self?.centerMap(on: coordinates)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = self?.viewModel?.city?.name
            annotation.subtitle = self?.viewModel?.city?.country
            
            self?.mapView.addAnnotation(annotation)
        }
        
        viewModel?.loadCityMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        checkLocationAuthorizationStatus()
    }
    
    // MARK: - CLLocationManager
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func centerMap(on coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 3000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
