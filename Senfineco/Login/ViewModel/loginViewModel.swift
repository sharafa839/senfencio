//
//  loginViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation
import RxCocoa
import RxSwift
class loginViewModel {
    var phone = BehaviorRelay<String>.init(value: "")
    var password = BehaviorRelay<String>.init(value: "")
    private var loginModelSubject = PublishSubject<LoginModel>()
    var loginModelObservable : Observable<LoginModel>{
        return loginModelSubject
    }
    func login(vc:UIViewController){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.login, method: .post, paameters: paramter.LoginParms(phone: phone.value, password: password.value), headers: Headers.AcceptContentHeader()) { [weak self](user:LoginModel?, err:Error?, code:Int?) in
            guard let self = self else {return}
            if code == 200 {
                if err == nil {
                    guard  let user = user else {return}
                    self.loginModelSubject.onNext(user)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }}else{
                HelperK.showError(title: "phoneOrPasswordwrong", subtitle: "")

            }}}
    
    
}
