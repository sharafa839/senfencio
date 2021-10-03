//
//  Profile.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxSwift
import RxCocoa

class Profile{
    private let profileResponse = PublishSubject<ProfileData>.init()
    var subscribeToRespnse : Observable<ProfileData> {
        return profileResponse
    }
    func getData(){
        APIs.genericApiWithPagination(pageNo: 0, url:URLS.profile, method: .post, paameters: nil, headers: Headers.AccepTTokenHeaders()) { (profile:ProfileData?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    guard  let profile = profile else {
                        return
                    }
                    self.profileResponse.onNext(profile)
                }else{
                    HelperK.showError(title: "err", subtitle: "")
                }
            }else{
                HelperK.showError(title: "err", subtitle: "")

            }
        }
    }
    func updateData(user:UserType,fname:String,lname:String,phone:String,email:String,crn:String?,company:String?){
        switch user {
        case .Customer:
            APIs.genericApiWithPagination(pageNo: 0, url:URLS.updateProfile + "customer", method: .put, paameters: paramter.updateProfileParms(fname: fname, lname: lname, email: email, phone: phone), headers: Headers.AccepTTokenHeaders()) { (profile:ProfileData?, err:Error?, code:Int?) in
                if code == 200 {
                    if err == nil {
                        guard  let profile = profile else {
                            return
                        }
                        self.profileResponse.onNext(profile)
                    }else{
                        HelperK.showError(title: "err", subtitle: "")
                    }
                }else{
                    HelperK.showError(title: "err", subtitle: "")

                }
            }
        case.Seller :
            APIs.genericApiWithPagination(pageNo: 0, url:URLS.updateProfile + "wholesaler", method: .put, paameters: paramter.updateProfileseller(fname: fname, lname: lname, email: email, phone: phone, company: company ?? "", crn: crn ?? ""), headers: Headers.AccepTTokenHeaders()) { (profile:ProfileData?, err:Error?, code:Int?) in
                if code == 200 {
                    if err == nil {
                        guard  let profile = profile else {
                            return
                        }
                        self.profileResponse.onNext(profile)
                    }else{
                        HelperK.showError(title: "err", subtitle: "")
                    }
                }else{
                    HelperK.showError(title: "err", subtitle: "")

                }
            }
        default:
            print("")
        }
    }
    func getProfileData(user:UserType)  {
        switch user {
        case .Customer:
          getData()
        case.Seller:
            getData()
        default:
            print("")
        }
    }
    
    
}
enum UserType {
    case Customer
    case Seller
}
