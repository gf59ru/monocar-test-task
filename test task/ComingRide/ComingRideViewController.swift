//
//  ComingRideViewController.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class ComingRideViewController: UIViewController
{    
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var driversCollectionView: UICollectionView!

    var presenter: ComingRidePresenter!
    
    private var startPoint: GMSMarker?
    private var endPoint: GMSMarker?
    private var driverStartPointSmall: GMSMarker?
    private var driverEndPointSmall: GMSMarker?
    private var driverStartPoint: GMSMarker?
    private var driverEndPoint: GMSMarker?
    
    private var startRoute: GMSPolyline?
    private var driverRoute: GMSPolyline?
    private var endRoute: GMSPolyline?
    
    private var firstTimeAppear = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if firstTimeAppear
        {
            firstTimeAppear = false
            showSelectedDriverOnMap(index: 0)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupViews()
    {
        setupTitle()
    }
    
    private func setupTitle()
    {
        titleLabel.text = "Знайдено \(presenter.comingRide.taxiDrivers.count)"
        
        titleView.layer.masksToBounds = false
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        titleView.layer.shadowRadius = 6
        titleView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    @IBAction func navigateBack(_ sender: Any)
    {
        dismiss(animated: true)
    }
    
    fileprivate func showSelectedDriverOnMap(index: Int)
    {
        clearRoutesAndMarkers()
    
        if index < 0 || index >= presenter.comingRide.taxiDrivers.count { return }
        
        let driver = presenter.comingRide.taxiDrivers[index]
    
        guard let startPath = GMSPath(fromEncodedPath: driver.routeStart),
              let driverPath = GMSPath(fromEncodedPath: driver.routeMain),
              let endPath = GMSPath(fromEncodedPath: driver.routeEnd)
        else { return }
        
        let strokeLengths = [NSNumber(value: 4), NSNumber(value: 4)]
    
        startRoute = GMSPolyline(path: startPath)
        startRoute!.strokeWidth = 2.5
        var strokeStyles = [GMSStrokeStyle.solidColor(#colorLiteral(red: 0, green: 0.8000000119, blue: 0.200000003, alpha: 1)), GMSStrokeStyle.solidColor(.clear)]
        startRoute!.spans = GMSStyleSpans(startPath, strokeStyles, strokeLengths, .geodesic)
        startRoute!.map = mapView
    
        driverRoute = GMSPolyline(path: driverPath)
        driverRoute!.strokeWidth = 2.5
        driverRoute!.strokeColor = #colorLiteral(red: 0.0120000001, green: 0.5059999824, blue: 0.9959999919, alpha: 1)
        driverRoute!.map = mapView
        
        endRoute = GMSPolyline(path: endPath)
        endRoute!.strokeWidth = 2.5
        strokeStyles = [GMSStrokeStyle.solidColor(#colorLiteral(red: 0.0120000001, green: 0.5059999824, blue: 0.9959999919, alpha: 1)), GMSStrokeStyle.solidColor(.clear)]
        endRoute!.spans = GMSStyleSpans(startPath, strokeStyles, strokeLengths, .geodesic)
        endRoute!.map = mapView
        
        startPoint = GMSMarker(position: presenter.comingRide.start.geo)
        startPoint!.icon = #imageLiteral(resourceName: "map_marker_pin")
        startPoint!.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        startPoint!.map = mapView
        
        endPoint = GMSMarker(position: presenter.comingRide.end.geo)
        endPoint!.icon = #imageLiteral(resourceName: "map_marker_pin")
        endPoint!.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        endPoint!.map = mapView
        
        driverStartPointSmall = GMSMarker(position: driver.pointPickup)
        driverStartPointSmall!.icon = #imageLiteral(resourceName: "map_marker_pickup_small")
        driverStartPointSmall!.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        driverStartPointSmall!.map = mapView
        
        driverEndPointSmall = GMSMarker(position: driver.pointDropoff)
        driverEndPointSmall!.icon = #imageLiteral(resourceName: "map_marker_dropoff_small")
        driverEndPointSmall!.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        driverEndPointSmall!.map = mapView
        
        driverStartPoint = GMSMarker(position: driver.pointPickup)
        driverStartPoint!.icon = #imageLiteral(resourceName: "map_marker_pickup")
        driverStartPoint!.groundAnchor = CGPoint(x: 0.5, y: 0.84)
        driverStartPoint!.map = mapView
        
        driverEndPoint = GMSMarker(position: driver.pointDropoff)
        driverEndPoint!.icon = #imageLiteral(resourceName: "map_marker_dropoff")
        driverEndPoint!.groundAnchor = CGPoint(x: 0.5, y: 0.84)
        driverEndPoint!.map = mapView
        
//        var coordinateBounds = GMSCoordinateBounds(coordinate: presenter.comingRide.start.geo, coordinate: presenter.comingRide.end.geo)
//        coordinateBounds = coordinateBounds.includingCoordinate(driver.pointPickup)
//        coordinateBounds = coordinateBounds.includingCoordinate(driver.pointDropoff)
        var coordinateBounds = GMSCoordinateBounds(path: startPath)
        coordinateBounds = coordinateBounds.includingPath(driverPath)
        coordinateBounds = coordinateBounds.includingPath(endPath)
        
        
        
        let cameraUpdate = GMSCameraUpdate.fit(coordinateBounds, with: UIEdgeInsets(top: 80, left: 30, bottom: 320, right: 30))
        mapView.animate(with: cameraUpdate)
    
//        guard let camera = mapView.camera(for: coordinateBounds, insets: UIEdgeInsets(top: 80, left: 30, bottom: 320, right: 30))
//        else { return }
//        mapView.animate(to: camera)
    }
    
    private func clearRoutesAndMarkers()
    {
        startPoint?.map = nil
        startPoint = nil
        
        endPoint?.map = nil
        endPoint = nil
        
        driverStartPointSmall?.map = nil
        driverStartPointSmall = nil
        
        driverEndPointSmall?.map = nil
        driverEndPointSmall = nil
        
        driverStartPoint?.map = nil
        driverStartPoint = nil
        
        driverEndPoint?.map = nil
        driverEndPoint = nil
        
        startRoute?.map = nil
        startRoute = nil
        
        driverRoute?.map = nil
        driverRoute = nil
        
        endRoute?.map = nil
        endRoute = nil
    }
    
}

extension ComingRideViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    private var itemWidth: CGFloat
    {
        UIScreen.main.bounds.width * 0.85
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        presenter.comingRide.taxiDrivers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let row = indexPath.row
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxiDriverCollectionViewCell", for: indexPath) as? TaxiDriverCollectionViewCell,
              row < presenter.comingRide.taxiDrivers.count
        else { return UICollectionViewCell() }
    
        let taxiDriver = presenter.comingRide.taxiDrivers[row]
        cell.setup(withDriver: taxiDriver, width: itemWidth)
        return cell
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        fixOffset(targetX: scrollView.contentOffset.x)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        fixOffset(targetX: targetContentOffset.pointee.x)
    }
    
    func fixOffset(targetX: CGFloat)
    {
        guard let layout = driversCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else { return }
        
        let itemSpacing = layout.minimumInteritemSpacing
        let count = presenter.comingRide.taxiDrivers.count
        let itemWidth = (driversCollectionView.contentSize.width - itemSpacing * CGFloat(count - 1)) / CGFloat(count)
        
        var x = CGFloat(0)
        var targetItem = Int(0)
        while x < targetX
        {
            x += itemWidth + itemSpacing
            targetItem += 1
        }
        
        let difference = x - targetX
        
        if difference > itemWidth / 2
        {
            targetItem -= 1
            x -= itemWidth
        }
        
        if targetItem >= count
        {
            targetItem = count - 1
        }
        
        x = CGFloat(targetItem) * itemWidth
        if targetItem == count - 1 { x -= UIScreen.main.bounds.width * 0.08 }
        else if targetItem > 0 { x -= UIScreen.main.bounds.width * 0.035 }
        
        driversCollectionView.contentOffset = CGPoint(x: driversCollectionView.contentOffset.x + 0.001, y: 0)
        
        driversCollectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        showSelectedDriverOnMap(index: targetItem)
    }
}
