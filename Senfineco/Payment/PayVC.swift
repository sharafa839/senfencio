//
//  PayVC.swift
//  Senfineco
//
//  Created by ahmed on 9/11/21.
//

import UIKit

class PayVC: UIViewController {

    @IBOutlet weak var payCashView: UIView!
    @IBOutlet weak var payCreditView: UIView!
    @IBOutlet weak
    var cusomView: UIView!{
        didSet{
            cusomView.setBottomRoundedEdge(desiredCurve: 2)
        }
    }
    @IBOutlet weak var payCash: UIButton!{
        didSet{
            payCash.setTitle("payCash", for: .normal)
        }
    }
    @IBOutlet weak var payCredit: UIButton!{
        didSet{
            payCredit.setTitle("payCredit", for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let maskPath = UIBezierPath(roundedRect:cusomView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                    cornerRadii: CGSize(width: 15, height: 15))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        cusomView.layer.mask = shape
        // Do any additional setup after loading the view.
    }
    

  

}
