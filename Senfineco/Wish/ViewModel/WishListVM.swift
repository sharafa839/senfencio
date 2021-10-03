//
//  WishListVM.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//


import Foundation
import RxCocoa
import RxSwift
class Wish {
    private let wishResponse = PublishSubject<[WishListPayload]>()
    var wishRespnseObservable : Observable<[WishListPayload]>{
        return wishResponse
    }
    func getWishes(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.listAllFavs, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (wishs:WishList?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard  let wish = wishs?.payload else {
                        return
                    }
                    self.wishResponse.onNext(wish)
                }else{
                    HelperK.showError(title: wishs?.message ?? "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: wishs?.message ?? "err", subtitle: "")

            }
        }
    }
}
