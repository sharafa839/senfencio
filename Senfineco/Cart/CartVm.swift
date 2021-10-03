//
//  CartVm.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxSwift
import RxCocoa
class CartVm {
    private let cartResponse = PublishSubject<Cart>.init()
    var subscripeToResponse : Observable<Cart>{
        return cartResponse
    }
    private let incResponse = PublishSubject<Increment>.init()
    var subscripeToincResponse : Observable<Increment>{
        return incResponse
    }
    private let decResponse = PublishSubject<Increment>.init()
    var subscripeTodecResponse : Observable<Increment>{
        return decResponse
    }
    private let delResponse = PublishSubject<deleteModel>.init()
    var subscripeTodelResponse : Observable<deleteModel>{
        return delResponse
    }
    func getCartData()  {
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.cart, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (cart:Cart?, err:Error?, code:Int?) in
            guard let self = self else {return}
            if code == 200 {
                if err == nil {
                    guard  let cart = cart else {
                        return
                    }
                    self.cartResponse.onNext(cart)
                }else{
                    HelperK.showError(title:"err".localizede, subtitle: "")
                }}else{
                HelperK.showError(title:"err".localizede, subtitle: "")
            }
        }
    }
    func increaseQuantity(id:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.incearsQuantity, method: .post, paameters: paramter.productID(productID: id), headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:Increment?, err:Error?, code:Int?) in
            LottieHelper.shared.hideAnimation()
            guard let self = self else {return}
            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.incResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")

                }}}}
    
    func decreaseQuantity(id:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.decreaseQuantity, method: .post, paameters: paramter.productID(productID: id), headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:Increment?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.incResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")
                }}}}
    func deleteProduct(id:String,vc:UIViewController){
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")

        APIs.genericApiWithPagination(pageNo: 0, url: URLS.deletedromCart+id, method: .delete, paameters: nil, headers: Headers.AccepTTokenHeaders()) { [weak self] (inc:deleteModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            LottieHelper.shared.hideAnimation()

            if code == 200 {
                if err == nil {
                    guard let inc = inc else {
                        return
                    }
                    self.delResponse.onNext(inc)
                    HelperK.showSuccess(title: inc.message ?? "", subtitle: "")

                }}}}
    
}
