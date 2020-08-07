//
//  Router.swift
//  test task
//
//  Created by Nikolai Borovennikov on 06.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit

class AppRouter
{

    static func present(comingRide: ComingRide, fromController: UIViewController)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ComingRideViewController") as? ComingRideViewController
        else { return }
        
        controller.modalPresentationStyle = .fullScreen
        
        let presenter = ComingRidePresenter(comingRide: comingRide)
        controller.presenter = presenter
        
        fromController.present(controller, animated: true)
    }

}
