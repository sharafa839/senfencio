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
    let street1=BehaviorRelay<String>.init(value: "")
    let street2 = BehaviorRelay<String>.init(value: "")
    let city = BehaviorRelay<String>.init(value: "")
    let country = BehaviorRelay<String>.init(value: "")
    let zip = BehaviorRelay<String>.init(value: "")
    let notes = BehaviorRelay<String>.init(value: "")
    let state = BehaviorRelay<String>.init(value: "")
    let addId = BehaviorRelay<String>.init(value: "")
    var isstreet1Valid : Observable<Bool>{
        return street1.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var isstreet2Valid : Observable<Bool>{
        return street2.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var iscityValid : Observable<Bool>{
        return city.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var iscountryValid : Observable<Bool>{
        return country.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var iszipValid : Observable<Bool>{
        return zip.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var isnotesValid : Observable<Bool>{
        return notes.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    var isstateValid : Observable<Bool>{
        return state.asObservable().map { (stereet1) -> Bool in
           return stereet1.isEmpty
        }
    }
    private var stata = BehaviorRelay<Bool>.init(value: false)
    var obs : Observable<Bool>{
        return Observable.combineLatest(isstreet1Valid, isstreet2Valid,iscityValid,iscountryValid,iszipValid,isnotesValid){ (a,b,c,d,e,f)  in
        
            let valid = !a && !b && !c && !d && !e && !f
            return valid
        }
    }
    func checkState(){
        if !street1.value.isEmpty && !street1.value.isEmpty && !city.value.isEmpty && !country.value.isEmpty && !zip.value.isEmpty && !notes.value.isEmpty && !state.value.isEmpty {
            stata.accept(true)
        }
    }
    private let myAddressSubject = PublishSubject<[AddressModelPayload]>.init()
    var subscribeToMyAddress : Observable <[AddressModelPayload]>{
        return myAddressSubject
    }
    private let newOrder = PublishSubject<MakeNewOrder>.init()
    var subscribeTonewOrder : Observable <MakeNewOrder>{
        return newOrder
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
    func makeNewOrderTextField(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.shipping, method:.post, paameters: paramter.shippingOrder(street1:street1.value, street2:street2.value , city: city.value, state: city.value, country: country.value , zip: zip.value , notes: notes.value , phone: HelperK.getphone(), addId:"null" ), headers: Headers.AccepTTokenHeaders()) { [weak self](order:MakeNewOrder?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                   
                    guard  let order = order else {
                        return
                    }
                    self.newOrder.onNext(order)
                    HelperK.showSuccess(title: order.message ?? "", subtitle: "")
                }
            }
        }
    }
    func makeNewOrder(address:AddressModelPayload,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.shipping, method:.post, paameters: paramter.shippingOrder(street1:address.address?.street1 ?? "", street2:address.address?.street2 ?? "" , city:address.address?.city ?? "", state: address.address?.city ?? "", country: address.address?.country ?? "" , zip: address.address?.zip ?? "" , notes:address.address?.notes ?? "" , phone: HelperK.getphone(), addId:address.id ?? "" ), headers: Headers.AccepTTokenHeaders()) { [weak self](order:MakeNewOrder?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard  let order = order else {
                        return
                    }
                    self.newOrder.onNext(order)
                    HelperK.showSuccess(title: order.message ?? "", subtitle: "")
                }
            }
        }
    }
}
