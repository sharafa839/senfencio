//
//  AddressTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit

class AddressTVC: UITableViewCell {

    @IBOutlet weak var addressP: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func confCell(address:AddressModelPayload){
        addressP.text = address.address?.street1
    }
}
