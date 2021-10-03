//
//  FilterViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxCocoa
import RxSwift
class Filter {
    private let FilterRespnse = PublishSubject<FilterModelPayload>()
    var subscribeToRespons : Observable<FilterModelPayload>{
        return FilterRespnse
    }
    func FetchData(vc:UIViewController)  {
        LottieHelper.shared.startAnimation(view: vc.view, name: "card")
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.filter, method: .post, paameters: nil, headers: Headers.AccepTTokenHeaders()) {[weak self] (filter:FilterModel?, err:Error?, code:Int?) in
            guard let self = self else {return}

            if code == 200 {
                if err == nil {
                    guard let fil = filter?.payload else {
                        return
                    }
                    self.FilterRespnse.onNext(fil)
                }else{
                    HelperK.showError(title: filter?.message ?? "err".localizede, subtitle: "")
                }
            }else{
                HelperK.showError(title: filter?.message ?? "err".localizede, subtitle: "")

            }
        }
    }
}
