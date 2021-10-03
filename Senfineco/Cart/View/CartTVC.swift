//
//  CartTVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit

class CartTVC: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var summtion: UIButton!
    @IBOutlet weak var delete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
