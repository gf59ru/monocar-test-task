//
// Created by Nikolai Borovennikov on 06.08.2020.
// Copyright (c) 2020 monocar. All rights reserved.
//

import Foundation
import CoreLocation

enum ComingRidePointKeys: String, CodingKey
{
    case geo = "geo"
    case alias = "alias"
    case name = "name"
    case address = "address"
}

struct ComingRidePoint: Decodable
{
    var geo: CLLocationCoordinate2D
    var alias: String
    var name: String
    var address: String
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: ComingRidePointKeys.self)
    
        geo = try container.decode(CLLocationCoordinate2D.self, forKey: .geo)
        alias = try container.decode(String.self, forKey: .alias)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
    }
}