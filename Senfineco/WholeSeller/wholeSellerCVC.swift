//
//  wholeSellerCVC.swift
//  Senfineco
//
//  Created by ahmed on 9/16/21.
//

import UIKit

class wholeSellerCVC: UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    func configCell(categoty:CategoryPayload){
        guard  let imge = categoty.image else {
            categoryImage.image = UIImage(named: "star")
            return
        }
        categoryImage.downlodImage(str:imge)
    }
}


