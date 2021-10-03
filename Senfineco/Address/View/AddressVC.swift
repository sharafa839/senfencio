//
//  AddressVC.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents
class AddressVC: UITableViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "Checkout".localizede
        }
    }
    @IBOutlet weak var addAddressla: UILabel!{
        didSet{
            addAddressla.text = "SelectYourAddress".localizede
        }
    }
    @IBOutlet weak var address: UILabel!{
        didSet{
            address.text = "addAddress".localizede
        }
    }
    @IBOutlet weak var addaddress: UIButton!{
        didSet{
            addaddress.addActionn(vc: self, action: #selector(animatingView))
            addaddress.setTitle("addAddress".localizede, for: .normal)

        }
    }
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.addActionn(vc: self, action: #selector(animatingView))
        }
    }
    @IBOutlet weak var tableVieww: UITableView!{
        didSet{
            tableVieww.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var addressView: UIView!{
        didSet{
            addressView.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var wholeAddress: MDCOutlinedTextField!{
        didSet{
            wholeAddress.label.text = "srteet 1 ".localizede
            wholeAddress.setOutlineColor(.borderColor, for: .editing)
            wholeAddress.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var buildingNumber: MDCOutlinedTextField!{
        didSet{
            buildingNumber.label.text = "street 2 ".localizede
            buildingNumber.setOutlineColor(.borderColor, for: .editing)
            buildingNumber.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var floorNumber: MDCOutlinedTextField!{
        didSet{
            floorNumber.label.text = "city".localizede
            floorNumber.setOutlineColor(.borderColor, for: .editing)
            floorNumber.setOutlineColor(.borderColor, for: .normal)

        }
    }
    @IBOutlet weak var UnitNumber: MDCOutlinedTextField!{
        didSet{
            UnitNumber.label.text = "country".localizede
            UnitNumber.setOutlineColor(.borderColor, for: .editing)
            UnitNumber.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var zip: MDCOutlinedTextField!{
        didSet{
            zip.label.text = "zip".localizede
            zip.setOutlineColor(.borderColor, for: .editing)
            zip.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var markPlace: MDCOutlinedTextField!{
        didSet{
            markPlace.label.text = "markPlace".localizede
            markPlace.setOutlineColor(.borderColor, for: .editing)
            markPlace.setOutlineColor(.borderColor, for: .normal)
        }
    }
    
    @IBOutlet weak var AddAddressButton: UIButton!{
        didSet{
            AddAddressButton.setTitle("addAddress".localizede, for: .normal)
            AddAddressButton.floatButton(raduis: 20)
        }
    }
    var isOpen : Bool = false
    let disposeBag = DisposeBag()
    var price = Int()
    let addressVM = AddressVm()
    var adressSelected:AddressModelPayload?
    var State = false
    var orderID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = nil
        tableVieww.rowHeight = 50
        getData()
        bindtextFields()
        subscribeToRespnse()
hideView()
        seletctedCell()
    
backButtonz()
        subscribeToAddAddressView()
        subscribeToCheckOutPutton()
        subscribeToButton()
        subscribe()
    }
    @objc func hideView(){
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        addressView.transform = scaleDownTransorm
        addressView.isHidden = true
    }
    @objc func animatingView(){
        if !isOpen  {
            addressView.isHidden = false

            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {[weak self] in
                    guard let self = self else {return}

                    self.addressView.transform = .identity
                    self.isOpen = true
                }
            }
        }else{
            hideView()
            self.isOpen = false

        }
       
    }
    func getData(){
        addressVM.getAllAddress()
    }
    func  subscribeToRespnse()  {
        addressVM.subscribeToMyAddress.bind(to: tableVieww.rx.items(cellIdentifier: "cell", cellType: AddressTVC.self)){ [weak self] row , data , cell in
        
            cell.addressP.text = data.address?.street1
        }.disposed(by: disposeBag)
    }
    func seletctedCell(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(AddressModelPayload.self)).bind{index , data in
            self.adressSelected = data
            guard let ad = self.adressSelected else{return}
            self.addressVM.makeNewOrder(address: ad, vc: self)

           /*    
*/
        
        }.disposed(by: disposeBag)
    }
    func subscribeToAddAddressView(){
        addaddress.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}
           
            self.animatingView()
        }.disposed(by: disposeBag)

    }
    func bindtextFields(){
        wholeAddress.rx.text.orEmpty.bind(to: addressVM.street1).disposed(by: disposeBag)
        buildingNumber.rx.text.orEmpty.bind(to: addressVM.street2).disposed(by: disposeBag)
        floorNumber.rx.text.orEmpty.bind(to: addressVM.city).disposed(by: disposeBag)
        UnitNumber.rx.text.orEmpty.bind(to: addressVM.country).disposed(by: disposeBag)

        zip.rx.text.orEmpty.bind(to: addressVM.zip).disposed(by: disposeBag)
        markPlace.rx.text.orEmpty.bind(to: addressVM.notes).disposed(by: disposeBag)


    }
    func backButtonz(){
        backButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)

    }
    func bindAddressToModel(){
        adressSelected?.address?.street1 = wholeAddress.text
        adressSelected?.address?.street2 = buildingNumber.text
        adressSelected?.address?.city = floorNumber.text
        adressSelected?.address?.country = UnitNumber.text
        adressSelected?.address?.state = floorNumber.text
        adressSelected?.address?.notes = markPlace.text
        adressSelected?.address?.zip = zip.text
        adressSelected?.id = addressVM.addId.value


    }
    func subscribe(){
        addressVM.subscribeTonewOrder.subscribe { (data) in
            self.orderID = data.element?.payload?.id ?? ""
            print("ahmed",self.price)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutVC
                vc.Pricee = "\(self.price)"
            vc.orderID = self.orderID
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }

    func subscribeToButton(){
        addressVM.obs.bind(to: AddAddressButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToCheckOutPutton(){

        AddAddressButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self](_) in

                guard let self = self else {return}
                self.AddAddressButton.secAnimation()
                self.addressVM.makeNewOrderTextField()
                self.addressVM.subscribeTonewOrder.subscribe { (data) in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutVC
                    vc.Pricee = "\(self.price)"
                        vc.address = self.adressSelected
                    vc.orderID = data.element?.payload?.id ?? ""
                self.present(vc, animated: true, completion: nil)
                }.disposed(by: self.disposeBag)

                   
            }.disposed(by: disposeBag)

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   

}
