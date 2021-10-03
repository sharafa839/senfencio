//
//  RegisterViewModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation
import RxSwift
import RxCocoa
class RegisterViewModel{
    let firstName=BehaviorRelay<String>.init(value: "")
    let lastName = BehaviorRelay<String>.init(value: "")
    let email = BehaviorRelay<String>.init(value: "")
    let phone = BehaviorRelay<String>.init(value: "")
    let password = BehaviorRelay<String>.init(value: "")
   private let registerModelSubject = PublishSubject<RegisterClientModel>()
    var observableRegisterModel : Observable<RegisterClientModel>{
        return registerModelSubject
    }
    
    var isEmailValid:Observable<Bool>{
        return email.asObservable().map { (email) -> Bool in
            let isEmailValids = email.isValidEmail
            return isEmailValids
        }
        }
    var isEmailEmpty:Observable<Bool>{
        return email.asObservable().map { (email) -> Bool in
            let isEmailEmptys = email.isEmpty
            return isEmailEmptys
        }
    }
    var isFNameEmpty:Observable<Bool>{
        return firstName.asObservable().map { (fName) -> Bool in
            let firstName = fName.isEmpty
            return firstName
        }
    }
    var isLNameEmpty:Observable<Bool>{
        return lastName.asObservable().map { (lName) -> Bool in
            let lastName = lName.isEmpty
            return lastName
        }
    }
    var isPhoneEmpty:Observable<Bool>{
        return phone.asObservable().map { (phonee) -> Bool in
            let myphone = phonee.isEmpty
            return myphone
        }
    }
    var ispassValid:Observable<Bool>{
        return password.asObservable().map { (passw) -> Bool in
            let mypass = passw.count > 5
            return mypass
        }
    }
    var isSignUpButtonIsEnabled:Observable<Bool>{
        return Observable.combineLatest(isEmailValid,isPhoneEmpty,isLNameEmpty,isFNameEmpty,ispassValid) { (myEmail,myPhone,myLastName,myFirstName,myPass) in
            let validate = myEmail&&myPhone&&myLastName&&myFirstName&&myPass
            return validate
        }
    }
    
    func register(){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.register, method: .post, paameters: paramter.registerParms(email: email.value, phone: phone.value, firstName: firstName.value, lastName: lastName.value, password: password.value), headers: Headers.AcceptContentHeader()) {[weak self] (user:RegisterClientModel?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard  let user = user else {
                        return
                    }
                    guard  let self = self  else {
                        return
                    }
                    self.registerModelSubject.onNext(user)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err", subtitle: "")
            }
            
        }
    }
    
}