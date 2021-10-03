//
//  TrackOrderVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxCocoa
import RxSwift

class TrackOrderVC: UITableViewController {
var id = String()
    let disposeBag = DisposeBag()
    var order : OrdersPayload?
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "Track Order"
        }
    }
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var amountOfMoney: UILabel!
    @IBOutlet weak var timeOfOrder: UILabel!
    @IBOutlet weak var accepted: UILabel!
    @IBOutlet weak var acceptedImag: UIImageView!{
        didSet{
            acceptedImag.image = UIImage(named: "package")?.withTintColor(.gray)
        }
    }
    @IBOutlet weak var acceptedTime: UILabel!
    @IBOutlet weak var acceptedDate: UILabel!

    @IBOutlet weak var processedImge: UIImageView!{
        didSet{
            processedImge.image = UIImage(named: "packaging")?.withTintColor(.gray)
        }
    }
    @IBOutlet weak var processed: UILabel!
    @IBOutlet weak var processedTime: UILabel!
    @IBOutlet weak var processedDate: UILabel!
    @IBOutlet weak var onWay: UILabel!
    @IBOutlet weak var onWayTime: UILabel!
    @IBOutlet weak var onWayDate: UILabel!
    @IBOutlet weak var onway: UILabel!
    @IBOutlet weak var onWayImage: UIImageView!{
        didSet{
            onWayImage.image = UIImage(named: "shipping")?.withTintColor(.gray)
        }
    }
    @IBOutlet weak var deliverdTime: UILabel!
    @IBOutlet weak var deliverdDate: UILabel!
    @IBOutlet weak var deliverd: UILabel!
    @IBOutlet weak var deliverdImage: UIImageView!{
        didSet{
            deliverdImage.image = UIImage(named: "package (1)")?.withTintColor(.gray)
        }
    }
    @IBOutlet weak var _1stView: UIView!{
        didSet{
            _1stView.clipsToBounds = true
            _1stView.setRoundCorners(_1stView.frame.size.height/2)
        }
    }
    @IBOutlet weak var _2stView: UIView!{
        didSet{
            _2stView.clipsToBounds = true
            _2stView.setRoundCorners(_2stView.frame.size.height/2)
        }
    }
    @IBOutlet weak var _3stView: UIView!{
        didSet{
            _3stView.clipsToBounds = true
            _3stView.setRoundCorners(_3stView.frame.size.height/2)
        }
    }
    @IBOutlet weak var _4stView: UIView!{
        didSet{
            _4stView.clipsToBounds = true
            _4stView.setRoundCorners(_4stView.frame.size.height/2)
        }
    }
    var orderTrack = Order()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView?.isHidden = true
        orderId.text = order?.id
        numberOfItems.text = "\(order?.items?.count ?? 00)  Items"
        amountOfMoney.text = "\(order?.totalCost ?? 00)   OMR"
        timeOfOrder.text = "Order at Senfineco : " + (order?.date)!
        // Do any additional setup after loading the view.
        backing()
        getdata()
        subscribeToResponse()
    }
    func backing()  {
        back.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}

            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    func getdata(){
        orderTrack.trackOrder(id: id)
    }
    func subscribeToResponse() {
        orderTrack.subscribeTrackRespone.subscribe { (data) in
            if data.element?.status == "pending"{
                self.acceptedImag.image = UIImage(named: "package")?.withTintColor(.orange)

            }
        }.disposed(by: disposeBag)
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

