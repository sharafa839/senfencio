//
//  WishListVC.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
class WishListVC: UIViewController {

    @IBOutlet weak var titleLa: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var back: UIButton!
    
    var dataSource : RxTableViewSectionedReloadDataSource<SectionModel>?
    let Wishs = Wish()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 180
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTVC
            cell.confCell(wish: Item)
            cell.addToCart.rx.tap.subscribe { (_) in

            }.disposed(by: self?.disposeBag ?? DisposeBag())

            return cell
            
        })
getData()
    backButton()
        subscribeToResponse()
        // Do any additional setup after loading the view.
    }
    func getData(){
        Wishs.getWishes()
        
    }
    func subscribeToResponse(){
        Wishs.wishRespnseObservable.map ({ SectionMode  in
            [SectionModel(header: "Ahmed", items: SectionMode)]
        
        }).bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
    }
    func backButton(){
        back.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.dismiss(animated: true, completion: nil)
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
