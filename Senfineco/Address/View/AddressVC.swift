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
            titleLa.text = "Checkout"
        }
    }
    @IBOutlet weak var addAddressla: UILabel!{
        didSet{
            addAddressla.text = "SelectYourAddress"
        }
    }
    @IBOutlet weak var address: UILabel!{
        didSet{
            address.text = "addAddress"
        }
    }
    @IBOutlet weak var addaddress: UIButton!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var addAddress: UIButton!
    @IBOutlet weak var tableVieww: UITableView!
    @IBOutlet weak var addressView: UIView!{
        didSet{
            addressView.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var wholeAddress: MDCOutlinedTextField!{
        didSet{
            wholeAddress.label.text = "whole Address"
            wholeAddress.setOutlineColor(.borderColor, for: .editing)
            wholeAddress.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var buildingNumber: MDCOutlinedTextField!{
        didSet{
            buildingNumber.label.text = "buildingNumber"
            buildingNumber.setOutlineColor(.borderColor, for: .editing)
            buildingNumber.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var floorNumber: MDCOutlinedTextField!{
        didSet{
            floorNumber.label.text = "floorNumber"
            floorNumber.setOutlineColor(.borderColor, for: .editing)
            floorNumber.setOutlineColor(.borderColor, for: .normal)

        }
    }
    @IBOutlet weak var UnitNumber: MDCOutlinedTextField!{
        didSet{
            UnitNumber.label.text = "UnitNumber"
            UnitNumber.setOutlineColor(.borderColor, for: .editing)
            UnitNumber.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var markPlace: MDCOutlinedTextField!{
        didSet{
            markPlace.label.text = "markPlace"
            markPlace.setOutlineColor(.borderColor, for: .editing)
            markPlace.setOutlineColor(.borderColor, for: .normal)
        }
    }
    @IBOutlet weak var AddAddressButton: UIButton!{
        didSet{
            AddAddressButton.setTitle("addAddress", for: .normal)
            AddAddressButton.floatButton(raduis: 20)
        }
    }
    let disposeBag = DisposeBag()
    var price = Int()
    let addressVM = AddressVm()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVieww.rowHeight = 50
        getData()
        subscribeToRespnse()
        deselectCell()
hideView()
        subscribeToAddAddressView()
        seletctedCell()

    }
    func hideView(){
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        addressView.transform = scaleDownTransorm
        addressView.isHidden = true
    }
    func animatingView(){
        addressView.isHidden = false

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {[weak self] in
                guard let self = self else {return}

                self.addressView.transform = .identity

            }
        }
    }
    func getData(){
        addressVM.getAllAddress()
    }
    func  subscribeToRespnse()  {
        addressVM.subscribeToMyAddress.bind(to: tableVieww.rx.items(cellIdentifier: "cell", cellType: AddressTVC.self)){ [weak self] row , data , cell in
        
            print(data.address?.street1,55555555)
            cell.addressP.text = "ahmeds"
        }.disposed(by: disposeBag)
    }
    func seletctedCell(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(AddressModelPayload.self)).bind{index , data in
                self.tableVieww.cellForRow(at: index)?.accessoryType = .checkmark
            print("ahmed" + data.id!)
            
        }.disposed(by: disposeBag)
    }
    func deselectCell(){
        Observable.zip(tableVieww.rx.itemDeselected, tableVieww.rx.modelSelected(AddressModelPayload.self)).bind{index , data in
                self.tableVieww.cellForRow(at: index)?.accessoryType = .none
            
        }.disposed(by: disposeBag)
    }
    func subscribeToAddAddressView(){
        addaddress.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}

            self.animatingView()
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
