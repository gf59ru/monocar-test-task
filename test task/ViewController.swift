//
//  ViewController.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func doRequest(_ sender: Any)
    {
        button.isEnabled = false
        activityIndicator.startAnimating()

        RequestHelper.getTaxiDrivers
        { [weak self] comingRide, error in
    
            DispatchQueue.main.async
            { [weak self] in
                self?.button.isEnabled = true
                self?.activityIndicator.stopAnimating()
            }

            if let `comingRide` = comingRide
            {
                print(comingRide)
                DispatchQueue.main.async
                { [weak self] in
                    guard let `self` = self else { return }
                    AppRouter.present(comingRide: comingRide, fromController: self)
                }
            }

            if let `error` = error
            {
                print(error)
                DispatchQueue.main.async
                { [weak self] in
                    self?.showFailureAlert()
                }
            }
        }
    }
    
    private func showFailureAlert()
    {
        let alertController = UIAlertController(title: nil, message: "Не удалось", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
        
        self.present(alertController, animated: true)
    }
}

