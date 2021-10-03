//
//  CartVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class CartVC: UIViewController {

    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "CART".localizede
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLa: UILabel!{
        didSet{
            totalPriceLa.text = "totalPrice".localizede
        }
    }
    @IBOutlet weak var priceLa: UILabel!{
        didSet{
            priceLa.text = "0 OMR".localizede
        }
    }
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.setTitle("Continue to checkout".localizede, for: .normal)
            payButton.floatButton(raduis: 20)
        }
    }
   
    
    var price = 0

    let cartVm = CartVm()
    var id = String()
    var dataSource : RxTableViewSectionedReloadDataSource<sectionCart>?

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subscribeToRes()

        }
    override func viewDidAppear(_ animated: Bool) {
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 150
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTVC
            cell.getCart(cart: Item)
            cell.delete.rx.tap.subscribe { [weak self](_) in
                guard let self = self else {return}
                self.cartVm.deleteProduct(id: Item.productID ?? "", vc: self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hom")
                self.present(vc!, animated: true, completion: nil)
            }.disposed(by: self?.disposeBag ?? DisposeBag())
            cell.minus.rx.tap.subscribe { [weak self](_) in
                guard let self = self else {return}
                self.cartVm.decreaseQuantity(id: Item.productID ?? "", vc: self)
               // self.cartVm.getCartData()

                guard var qu =  Int(cell.quantity.text ?? "0") else {return}
                qu -= 1
                cell.quantity.text = "\(qu)"
         

            }.disposed(by: self?.disposeBag ?? DisposeBag())
            cell.summtion.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                self.cartVm.increaseQuantity(id: Item.productID ?? "", vc: self)
              //  self.cartVm.getCartData()
               

                guard var qu =  Int(cell.quantity.text ?? "0") else {return}
                qu += 1
                cell.quantity.text = "\(qu)"
                
            }.disposed(by: self?.disposeBag ?? DisposeBag())

            return cell
            })
    
        
        getData()
        getDataInTableView()
        subscribeTocheckOut()
subscribeWhenTappedInCell()
    }
    override func viewDidDisappear(_ animated: Bool) {
        price = 0
        dataSource = nil
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    func getData(){
        cartVm.getCartData()
    }
    func subscribeToRes(){
        cartVm.subscripeToResponse.subscribe {[weak self] (data) in

            guard let self = self else {return}
               // self.payButton.isEnabled = false
            self.price = 0

            guard let pro = data.element?.payload?.products else {return}
         
            for i in pro{
                self.price += i.total!
                self.priceLa.text = "\(self.price)" + "   OMR".localizede
            }
           
        }.disposed(by: disposeBag)
        
    }
    func subscribeTocheckOut(){
        payButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}
           
            self.payButton.secAnimation()

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "address") as! AddressVC
            vc.price = self.price
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    func getDataInTableView(){
        
        cartVm.subscripeToResponse.map{ cart in
            [sectionCart(items: cart.payload?.products ?? [Products](), heades: "")]
        }.bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        
}
    func subscribeWhenTappedInCell(){
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Products.self)).bind {[weak self]selectedInsex,model in
            guard let self = self else {return}

            self.id = model.productID ?? ""
            print(self.id)
        }.disposed(by: disposeBag)
       
    }
    @objc func minusQuantity (sender:UIButton){
        cartVm.decreaseQuantity(id:id, vc: self)
        subscribeToRes()
}
    @objc func addQuantity (sender:UIButton){
        cartVm.increaseQuantity(id: id, vc: self)
        subscribeToRes()
}
    @objc func delete (sender:UIButton){
        cartVm.deleteProduct(id: id, vc: self)
}

}

