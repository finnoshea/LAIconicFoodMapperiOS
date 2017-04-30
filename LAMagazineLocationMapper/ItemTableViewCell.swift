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

protocol VisitedDelegate: class {
    // See http://stackoverflow.com/questions/39566065/uiswitch-in-accessory-view-of-a-tableviewcell-passing-a-parameter-with-the-sele
    
    func didFlipVisitSwitch(for cell: ItemTableViewCell, value: Bool)
}

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    weak var delegate: VisitedDelegate? = nil
    
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
    }
    
    // Animate the switch functionality
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func blankFunction() {
        // a blank function so I can commit to git
    }

}












