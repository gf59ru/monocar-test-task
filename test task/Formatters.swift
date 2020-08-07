//
// Created by Nikolai Borovennikov on 07.08.2020.
// Copyright (c) 2020 monocar. All rights reserved.
//

import Foundation

class Formatters
{
    static let dateFormatter: DateFormatter =
    {
        let result = DateFormatter()
        result.dateFormat = "dd.MM.yyyy"
        return result
    }()
    
    static let timeFormatter: DateFormatter =
    {
        let result = DateFormatter()
        result.dateFormat = "hh:mm"
        return result
    }()
    
    static let rateFormatter: NumberFormatter =
    {
        let result = NumberFormatter()
        result.positiveFormat = "0.#"
        return result
    }()
}