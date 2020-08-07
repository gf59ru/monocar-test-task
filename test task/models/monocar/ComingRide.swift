//
//  TaxiDrivers.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import Foundation
import CoreLocation

enum ComingRideKeys: String, CodingKey
{
    case paymentType = "payment_type"
    case amount = "amount"
    case dtInterval = "dt_interval"
    case id = "id"
    case resultsCount = "results_count"
    case minRating = "min_rating"
    case costPerSeat = "cost_per_seat"
    case radius = "radius"
    case end = "end"
    case isDriver = "is_driver"
    case start = "start"
    case isSearching = "is_searching"
    case taxiDrivers = "results"
    case dtRide = "dt_ride"
    case appId = "app_id"
    case user = "user"
    case dtCreate = "dt_create"
    case route = "route"
    case seatsCount = "seats_count"
}

struct DynamicCodingKeys: CodingKey
{
    private(set) var stringValue: String = ""
    private(set) var intValue: Int? = nil
    
    init?(stringValue: String)
    {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int)
    {
        self.intValue = intValue
    }
}

struct ComingRide: Decodable
{
    var paymentType: Int
    var amount: Int
    var dtInterval: TimeInterval
    var id: String
    var resultsCount: Int
    var minRating: Decimal
    var costPerSeat: Decimal
    var radius: CLLocationDistance
    var end: ComingRidePoint
    var isDriver: Bool
    var start: ComingRidePoint
    var isSearching: Bool
    var taxiDrivers: [TaxiDriver]
    var dtRide: TimeInterval
    var appId: Int
    var user: User
    var dtCreate: TimeInterval
    var route: ComingRideRoute
    var seatsCount: Int
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: ComingRideKeys.self)
        
        paymentType = try container.decode(Int.self, forKey: .paymentType)
        amount = try container.decode(Int.self, forKey: .amount)
        dtInterval = try container.decode(TimeInterval.self, forKey: .dtInterval)
        id = try container.decode(String.self, forKey: .id)
        resultsCount = try container.decode(Int.self, forKey: .resultsCount)
        minRating = try container.decode(Decimal.self, forKey: .minRating)
        costPerSeat = try container.decode(Decimal.self, forKey: .costPerSeat)
        radius = try container.decode(CLLocationDistance.self, forKey: .radius)
        end = try container.decode(ComingRidePoint.self, forKey: .end)
        isDriver = try container.decode(Bool.self, forKey: .isDriver)
        start = try container.decode(ComingRidePoint.self, forKey: .start)
        isSearching = try container.decode(Bool.self, forKey: .isSearching)
        
        let driversContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: ComingRideKeys.taxiDrivers)
    
        taxiDrivers = []
        for key in driversContainer.allKeys
        {
            let taxiDriver = try driversContainer.decode(TaxiDriver.self, forKey: key)
            taxiDrivers.append(taxiDriver)
        }
    
        dtRide = try container.decode(TimeInterval.self, forKey: .dtRide)
        appId = try container.decode(Int.self, forKey: .appId)
        user = try container.decode(User.self, forKey: .user)
        dtCreate = try container.decode(TimeInterval.self, forKey: .dtCreate)
        route = try container.decode(ComingRideRoute.self, forKey: .route)
        seatsCount = try container.decode(Int.self, forKey: .seatsCount)
    }
}
