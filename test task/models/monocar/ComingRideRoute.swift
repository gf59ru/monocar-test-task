//
// Created by Nikolai Borovennikov on 06.08.2020.
// Copyright (c) 2020 monocar. All rights reserved.
//

import Foundation
import CoreLocation

enum ComingRideRouteKeys: String, CodingKey
{
    case duration = "duration"
    case part = "part"
    case distance = "distance"
    case type = "type"
    case polyline = "polyline"
}
struct ComingRideRoute: Decodable
{
    var duration: TimeInterval
    var part: String
    var distance: CLLocationDistance
    var type: Int
    var polyline: String
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: ComingRideRouteKeys.self)
    
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        part = try container.decode(String.self, forKey: .part)
        distance = try container.decode(CLLocationDistance.self, forKey: .distance)
        type = try container.decode(Int.self, forKey: .type)
        polyline = try container.decode(String.self, forKey: .polyline)
    
    }
}