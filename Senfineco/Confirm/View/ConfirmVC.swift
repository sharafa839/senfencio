//
//  ConfirmVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit

class ConfirmVC: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!{
        didSet{
            confirmButton.setTitle("confirm", for: .normal)
            confirmButton.floatButton(raduis: 20)
        }
    }
    @IBOutlet weak var confrmLA: UILabel!
    @IBOutlet weak var _tf1: UITextField!
    @IBOutlet weak var _tf2: UITextField!
    @IBOutlet weak var _tf3: UITextField!
    @IBOutlet weak var _tf4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
