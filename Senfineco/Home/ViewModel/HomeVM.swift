//
//  HomeVM.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
import RxSwift
import RxCocoa
class HomeVM {
    private let publishCategoryResponse = PublishSubject<[CategoryPayload]>.init()
    var subscribeCategoryResponse : Observable<[CategoryPayload]>{
        return publishCategoryResponse
    }
    private let publishProductResponse = PublishSubject<[ProductPayload]>.init()
    var subscribeProductResponse : Observable<[ProductPayload]>{
        return publishProductResponse
    }
    func getCategory(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.category, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (category:Category?, err:Error?, code:Int?) in
            if code == 200 {
                guard let self = self else {return}

                if err == nil {
                    guard  let cat = category?.payload  else {
                        return
                    }
                    self.publishCategoryResponse.onNext(cat)
                }else{
                    HelperK.showError(title: category?.message ?? "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: category?.message ?? "err", subtitle: "")

            }
        }
    }

    func getProduct(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.fetchAllProducts, method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (category:Product?, err:Error?, code:Int?) in
            if code == 200 {
                guard let self = self else {return}

                if err == nil {
                    guard  let cat = category?.payload  else {
                        return
                    }
                    self.publishProductResponse.onNext(cat)
                }else{
                    HelperK.showError(title: category?.message ?? "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: category?.message ?? "err", subtitle: "")

            }
        }
    }
    func getProductByCategory(productName:String){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.ProductInOneCategoty + productName , method: .get, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (products:Product?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard  let cat = products?.payload  else {
                        return
                    }
                    self.publishProductResponse.onNext(cat)
                }else{
                    HelperK.showError(title: products?.message ?? "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: products?.message ?? "err", subtitle: "")
            }
        }
    }
}
