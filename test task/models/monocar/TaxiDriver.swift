//
//  TaxiDriver.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import Foundation
import CoreLocation

enum TaxiDriverKeys: String, CodingKey
{
    case seatsCount = "seats_count"
    case userUid = "user_uid"
    case rating = "rating"
    case ridesCount = "rides_count"
    case pictureUrl = "picture_url"
    case costPerSeat = "cost_per_seat"
    case routeStart = "route_start"
    case isVerified = "is_verified"
    case routeMain = "route_main"
    case isDriver = "is_driver"
    case name = "name"
    case routeEnd = "route_end"
    case amount = "amount"
    case routeDriver = "route_driver"
    case dtStart = "dt_start"
    case routeMainDistance = "route_main_distance"
    case pointDropoff = "point_dropoff"
    case pointDriverEnd = "point_driver_end"
    case recId = "rec_id"
    case pointPickup = "point_pickup"
    case isSent = "is_sent"
    case paymentType = "payment_type"
    case pointDriverStart = "point_driver_start"
    case rideId = "ride_id"
}

struct TaxiDriver: Decodable
{

    var seatsCount: Int
    var userUid: String
    var rating: Decimal
    var ridesCount: Int
    var pictureUrl: String
    var costPerSeat: Decimal
    var routeStart: String
    var isVerified: Bool
    var routeMain: String
    var isDriver: Bool
    var name: String
    var routeEnd: String
    var amount: Int
    var routeDriver: String
    var dtStart: TimeInterval
    var routeMainDistance: CLLocationDistance
    var pointDropoff: CLLocationCoordinate2D
    var pointDriverEnd: CLLocationCoordinate2D
    var recId: Int
    var pointPickup: CLLocationCoordinate2D
    var isSent: Bool
    var paymentType: Int
    var pointDriverStart: CLLocationCoordinate2D
    var rideId: String

    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: TaxiDriverKeys.self)
    
        userUid = try container.decode(String.self, forKey: .userUid)
        seatsCount = try container.decode(Int.self, forKey: .seatsCount)
        rating = try container.decode(Decimal.self, forKey: .rating)
        ridesCount = try container.decode(Int.self, forKey: .ridesCount)
        pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        costPerSeat = try container.decode(Decimal.self, forKey: .costPerSeat)
        routeStart = try container.decode(String.self, forKey: .routeStart)
        isVerified = try container.decode(Bool.self, forKey: .isVerified)
        routeMain = try container.decode(String.self, forKey: .routeMain)
        isDriver = try container.decode(Bool.self, forKey: .isDriver)
        name = try container.decode(String.self, forKey: .name)
        routeEnd = try container.decode(String.self, forKey: .routeEnd)
        amount = try container.decode(Int.self, forKey: .amount)
        routeDriver = try container.decode(String.self, forKey: .routeDriver)
        dtStart = try container.decode(TimeInterval.self, forKey: .dtStart)
        routeMainDistance = try container.decode(CLLocationDistance.self, forKey: .routeMainDistance)
        pointDropoff = try container.decode(CLLocationCoordinate2D.self, forKey: .pointDropoff)
        pointDriverEnd = try container.decode(CLLocationCoordinate2D.self, forKey: .pointDriverEnd)
        recId = try container.decode(Int.self, forKey: .recId)
        pointPickup = try container.decode(CLLocationCoordinate2D.self, forKey: .pointPickup)
        isSent = try container.decode(Bool.self, forKey: .isSent)
        paymentType = try container.decode(Int.self, forKey: .paymentType)
        pointDriverStart = try container.decode(CLLocationCoordinate2D.self, forKey: .pointDriverStart)
        rideId = try container.decode(String.self, forKey: .rideId)
    }

}
