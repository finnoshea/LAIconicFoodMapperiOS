//
//  ItemTableViewCell.swift
//  LAMagazineLocationMapper
//
//  Created by Finn on 4/13/17.
//  Copyright © 2017 Finn. All rights reserved.
//
// A post on adding tap gestures to labels: http://stackoverflow.com/questions/37630921/how-to-addtarget-to-uilabel-in-swift

import UIKit
import os.log

protocol ButtonDelegate: class {
    // See http://stackoverflow.com/questions/39566065/uiswitch-in-accessory-view-of-a-tableviewcell-passing-a-parameter-with-the-sele
    
    func didFlipVisitSwitch(for cell: ItemTableViewCell, value: Bool)
    // function for actions to take when the boolean switch is triggered
    
    func didTapLocationLabel(for cell: ItemTableViewCell)
    // function for actions to take when the UILabel locationLabel is tapped
    
    func didSwipeLocationLabelRight(for cell: ItemTableViewCell)
    // function for actions to take when the UILabel locationLabel is swiped right
    
    func didSwipeLocationLabelLeft(for cell: ItemTableViewCell)
    // function for actions to take when the UILabel locationLabel is swiped right
}

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    weak var delegate: ButtonDelegate? = nil
    var isMobile: Bool = false
    var disableMarkers = false
    var chain = false
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var visitSwitch: UISwitch!
    
    //MARK: Actions
    @IBAction func visitSwitchTapped(_ sender: UISwitch) {
        delegate?.didFlipVisitSwitch(for: self, value: sender.isOn)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
        
        // Add a gesture recognizer to the UILabel location label
        // following: http://stackoverflow.com/questions/37871206/how-can-i-add-a-uitapgesturerecognizer-to-a-uilabel-inside-a-table-view-cell-sw
        let tapLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedLocationLabel))
        tapLabel.delegate = self
        locationLabel.addGestureRecognizer(tapLabel)
        // following: http://stackoverflow.com/questions/24215117/how-to-recognize-swipe-in-all-4-directions
        let swipeLabelRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLocationLabelRight))
        swipeLabelRight.direction = .right // this is default, but leave it for completeness
        swipeLabelRight.delegate = self
        locationLabel.addGestureRecognizer(swipeLabelRight)
        
        let swipeLabelLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLocationLabelLeft))
        swipeLabelLeft.direction = .left
        swipeLabelLeft.delegate = self
        locationLabel.addGestureRecognizer(swipeLabelLeft)
    }
    // What I call a left swipe and what Swift thinks is a left swipe are opposite, no idea why.
    //MARK: function that does stuff when the location label is tapped
    func tappedLocationLabel(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            delegate?.didTapLocationLabel(for: self)
        }
    }
    
    //MARK: function that does stuff when the location label is swiped right
    func swipedLocationLabelRight(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            delegate?.didSwipeLocationLabelRight(for: self)
        }
    }
    
    //MARK: function that does stuff when the location label is swiped right
    func swipedLocationLabelLeft(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            delegate?.didSwipeLocationLabelLeft(for: self)
        }
    }
    
    // Animate the switch functionality
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}












