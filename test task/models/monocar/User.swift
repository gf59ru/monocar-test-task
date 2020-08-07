//
// Created by Nikolai Borovennikov on 06.08.2020.
// Copyright (c) 2020 monocar. All rights reserved.
//

import Foundation

enum UserKeys: String, CodingKey
{
    case userUid = "user_uid"
    case name = "name"
    case phone = "phone"
    case isVerified = "is_verified"
    case ridesCount = "rides_count"
    case pictureUrl = "picture_url"
    case rating = "rating"
    case likes = "likes"
}

struct User: Decodable
{
    var userUid: String
    var name: String
    var phone: String
    var isVerified: Bool
    var ridesCount: Int
    var pictureUrl: String
    var rating: Decimal
    var likes: Int
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: UserKeys.self)
    
        userUid = try container.decode(String.self, forKey: .userUid)
        name = try container.decode(String.self, forKey: .name)
        phone = try container.decode(String.self, forKey: .phone)
        isVerified = try container.decode(Bool.self, forKey: .isVerified)
        ridesCount = try container.decode(Int.self, forKey: .ridesCount)
        pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        rating = try container.decode(Decimal.self, forKey: .rating)
        likes = try container.decode(Int.self, forKey: .likes)
    }
}