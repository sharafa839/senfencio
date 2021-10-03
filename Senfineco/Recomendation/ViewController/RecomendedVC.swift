//
//  RecomendedVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit
import RxSwift
import RxCocoa
class RecomendedVC: UIViewController {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var resultLa: UILabel!{
        didSet{
            resultLa.text = "result"
        }
    }
    @IBOutlet weak var content: UILabel!
    var type = String()
    var make = String()
    var model = String()
    let recomend = Recomend()
    let dispseBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let maskPath = UIBezierPath(roundedRect:customView.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                    cornerRadii: CGSize(width: 15, height: 15))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        customView.layer.mask = shape
getData()
        subscribeToData()
        // Do any additional setup after loading the view.
    }
    
    func getData()  {
        recomend.getRecomend(make: make, model: model, type: type)
    }
    func subscribeToData(){
        recomend.subscribeRecomed.subscribe { [weak self](data) in
            guard let self = self else {return}
            guard let element = data.element else {return}
            self.content.text = element.first?.resutls
        }.disposed(by:dispseBag )

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
