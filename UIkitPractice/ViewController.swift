//
//  ViewController.swift
//  UIkitPractice
//
//  Created by Ｍason Chang on 2017/7/28.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    
    let segmentControl: UISegmentedControl = {
        //item有幾個就會有幾個上面的button
        let sc = UISegmentedControl(items: ["Zero", "One", "Two","Taiwan NO 1"])
        // note translatesAutoresizingMaskIntoConstraints是否要添加隱含的constrain
        // 資料來源: http://blog.csdn.net/u010140921/article/details/40627983
        sc.translatesAutoresizingMaskIntoConstraints = false
        // 一開始看要hightlight哪個欄位
        sc.selectedSegmentIndex = 1
        // 依照內容去調整segmentControl button大小
        sc.apportionsSegmentWidthsByContent = true
 
        //整個segment是否可以被選取
        sc.isEnabled = true
        //回傳是否這個segment可被選取
        print(sc.isEnabledForSegment(at: 0))
        // 插入segment
        sc.insertSegment(withTitle: "I'm inserter", at: 3, animated: true)
        // 設定第幾個segment不能被選取
        sc.setEnabled(false, forSegmentAt: 3)
        
        return sc
    }()
    
    var mapView: MKMapView = {
        
        let mv = MKMapView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        

        return mv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        view.addSubview(segmentControl)
        view.addSubview(mapView)
        setSegmentControl()
        setMapView()
        
        // 2. 配置 locationManager
        locationManager?.delegate = self;
        locationManager?.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 3. 配置 mapView
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // 4. 加入測試數據
        setupData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1. 還沒有詢問過用戶以獲得權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestAlwaysAuthorization()
        }
            // 2. 用戶不同意
        else if CLLocationManager.authorizationStatus() == .denied {
            //showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. 用戶已經同意
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func setSegmentControl() {
        // need x y width height constraints
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setMapView() {
        mapView.centerXAnchor.constraint(equalTo: segmentControl.centerXAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20).isActive = true
        mapView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true

    }
    
    func setupData() {
        // 1. 檢查系統是否能夠監視 region
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            // 2.準備 region 會用到的相關屬性
            let title = "Lorrenzillo's"
            let coordinate = CLLocationCoordinate2DMake(37.703026, -121.759735)
            let regionRadius = 300.0
            
            // 3. 設置 region 的相關屬性
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager?.startMonitoring(for: region)
            
            // 4. 創建大頭釘(annotation)
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            mapView.addAnnotation(restaurantAnnotation)
            
            // 5. 繪製一個圓圈圖形（用於表示 region 的範圍）
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapView.add(circle)
        }
        else {
            print("System can't track regions")
        }
    }
    
    // 6. 繪製圓圈
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 1. 當用戶進入一個 region
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //showAlert("enter \(region.identifier)")
    }
    
    // 2. 當用戶退出一個 region
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //showAlert("exit \(region.identifier)")
    }


}

