//
//  RequestHelper.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit

class RequestHelper: NSObject
{
    static func getTaxiDrivers(completionHandler: @escaping (_ comingRide: ComingRide?, _ error: Error?) -> Void)
    {
        guard let url = URL(string: "https://europe-west3-fb-monocar.cloudfunctions.net/getRequestTest")
        else
        {
            completionHandler(nil, nil)
            return
        }

        let request = URLRequest(url: url)

        let session = URLSession(configuration: URLSessionConfiguration.default)

        let urlSessionTask = session.dataTask(with: request)
        { data, response, requestError in
            if let `requestError` = requestError
            {
                completionHandler(nil, requestError)
                return
            }
            
            guard let `data` = data
            else
            {
                completionHandler(nil, nil)
                return
            }
            
            let decoder = JSONDecoder()
            do
            {
                let comingRide = try decoder.decode(ComingRide.self, from: data)
                completionHandler(comingRide, requestError)
            }
            catch
            {
                completionHandler(nil, error)
            }

        }
        urlSessionTask.resume()
    }
    
    static func downloadAvatar(taxiDriver: TaxiDriver, completionHandler: @escaping (_ avatar: UIImage?, _ error: Error?) -> Void)
    {
        guard let url = URL(string: taxiDriver.pictureUrl)
        else
        {
            completionHandler(nil, nil)
            return
        }
    
        let request = URLRequest(url: url)
    
        let session = URLSession(configuration: URLSessionConfiguration.default)
    
        let urlSessionTask = session.dataTask(with: request)
        { data, response, requestError in
            if let `requestError` = requestError
            {
                completionHandler(nil, requestError)
                return
            }
    
            guard let `data` = data,
                  let image = UIImage(data: data)
            else
            {
                completionHandler(nil, nil)
                return
            }
            
            completionHandler(image, nil)
        }
        urlSessionTask.resume()
    }
}
