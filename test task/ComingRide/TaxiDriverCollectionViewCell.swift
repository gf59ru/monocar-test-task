//
//  TaxiDriverCollectionViewCell.swift
//  test task
//
//  Created by Nikolai Borovennikov on 06.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit

class TaxiDriverCollectionViewCell: UICollectionViewCell
{
    @IBOutlet private weak var backgroundRoundedView: UIView!
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var costLabel: UILabel!

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var seatCountLabel: UILabel!

    @IBOutlet private weak var applyButton: UIButton!

    @IBOutlet private weak var backgroundViewWidthConstraint: NSLayoutConstraint!

    func setup(withDriver driver: TaxiDriver, width: CGFloat)
    {
        setupViewsLook(width: width)
        
        nameLabel.text = driver.name
        rateLabel.text = Formatters.rateFormatter.string(for: driver.rating)
        roleLabel.text = driver.isDriver ? "(Водій)" : ""
        
        let dtStart = Date(timeIntervalSince1970: driver.dtStart)
        
        timeLabel.text = Formatters.timeFormatter.string(from: dtStart)
        costLabel.text = "\(driver.amount) ₴"
    
        dateLabel.text = Formatters.dateFormatter.string(from: dtStart)
        seatCountLabel.text = "\(driver.seatsCount)"
    
        getAvatar(driver: driver)
    }
    
    private func getAvatar(driver: TaxiDriver)
    {
        RequestHelper.downloadAvatar(taxiDriver: driver)
        { [weak self] image, error in
            if let `error` = error
            {
                print(error)
                return
            }
            
            guard let `image` = image else { return }
            DispatchQueue.main.async
            { [weak self] in
                guard let `self` = self else { return }
                self.avatarImageView.image = image
            }
        }
    }
    
    private func setupViewsLook(width: CGFloat)
    {
        backgroundViewWidthConstraint.constant = width
        
        backgroundRoundedView.layer.masksToBounds = false
        backgroundRoundedView.layer.cornerRadius = 8
    
        backgroundRoundedView.layer.shadowOpacity = 1
        backgroundRoundedView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        backgroundRoundedView.layer.shadowRadius = 6
        backgroundRoundedView.layer.shadowOffset = CGSize(width: 0, height: 4)
    
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 24
    
        applyButton.layer.masksToBounds = true
        applyButton.layer.cornerRadius = 8
    }
}
