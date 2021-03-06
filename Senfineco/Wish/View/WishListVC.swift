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

    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "wish List".localizede
        }
    }
    @IBOutlet weak var tableView: UITableView!
    let product = ProductVM()


    var dataSource : RxTableViewSectionedReloadDataSource<SectionModel>?
    let Wishs = Wish()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 180
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTVC
            cell.confCell(wish: Item)
            cell.addToCart.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.product.AddToCart(productId: Item.productID ?? "", quantity: 1, customer: true, vc: self)
            }.disposed(by: self?.disposeBag ?? DisposeBag())
            cell.delete.rx.tap.subscribe { [weak self](_) in
                guard let self = self else {return}
                self.Wishs.deleteFromWishList(id: Item.id
                                                ?? "", vc: self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                self.present(vc!, animated: true, completion: nil)
            }.disposed(by: self?.disposeBag ?? DisposeBag())

            return cell
            
        })
getData()
        subscribeToResponse()
        // Do any additional setup after loading the view.
    }
    func getData(){
        Wishs.getWishes()
        
    }
    func subscribeToResponse(){
        Wishs.wishRespnseObservable.map ({ SectionMode  in
            [SectionModel(header: "", items: SectionMode)]
        
        }).bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
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
