//
//  ColorCell.swift
//  XorO
//
//  Created by Armen Shahvaladyan on 11/10/19.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {

    static let reuseIdentifier = "ColorCellIdentifier"
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
           
    }
}
