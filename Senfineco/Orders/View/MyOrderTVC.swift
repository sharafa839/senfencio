//
//  MyOrderTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit

class MyOrderTVC: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var orderAtSncfico: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var amountOfMoney: UILabel!
    @IBOutlet weak var trackButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
