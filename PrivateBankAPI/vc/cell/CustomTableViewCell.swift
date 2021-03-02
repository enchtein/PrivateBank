//
//  CustomTableViewCell.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var safeRateNBLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
