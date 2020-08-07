//
// Created by Nikolai Borovennikov on 06.08.2020.
// Copyright (c) 2020 monocar. All rights reserved.
//

import CoreLocation

private enum CLLocationCoordinate2DKeys: String, CodingKey
{
    case latitude, longitude
}

extension CLLocationCoordinate2D: Decodable
{
    public init(from decoder: Decoder) throws
    {
        self.init()
        
        let container = try decoder.container(keyedBy: CLLocationCoordinate2DKeys.self)
    
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
}