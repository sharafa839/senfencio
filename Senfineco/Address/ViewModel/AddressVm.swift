//
//  File.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxCocoa
import RxSwift
class AddressVm {
    let wholeAddress=BehaviorRelay<String>.init(value: "")
    let buildNumber = BehaviorRelay<String>.init(value: "")
    let floorNumber = BehaviorRelay<String>.init(value: "")
    let unitNumber = BehaviorRelay<String>.init(value: "")
    let mark = BehaviorRelay<String>.init(value: "")
    private let myAddressSubject = PublishSubject<[AddressModelPayload]>.init()
    var subscribeToMyAddress : Observable <[AddressModelPayload]>{
        return myAddressSubject
    }
    func getAllAddress(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.allAdress, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (address:AddressModel?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                    guard  let addresss = address?.payload else {
                        return
                    }
                    self.myAddressSubject.onNext(addresss)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err", subtitle: "")

            }
        }
    }
    func AddAddress(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.addNewAddress, method:.post, paameters: paramter.AdreessParms(name: "", street: "", phone: "", city: "", postalCode: "", country: ""), headers: Headers.AccepTTokenHeaders()) { (add:AddressModel?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    
                }
            }
        }
    }

}
