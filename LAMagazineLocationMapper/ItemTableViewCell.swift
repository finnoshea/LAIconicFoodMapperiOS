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
}

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    weak var delegate: ButtonDelegate? = nil
    
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
        
    }
    
    //MARK: function that does stuff when the location label is tapped
    func tappedLocationLabel(sender: UITapGestureRecognizer) {
        delegate?.didTapLocationLabel(for: self)
    }
    
    // Animate the switch functionality
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}












