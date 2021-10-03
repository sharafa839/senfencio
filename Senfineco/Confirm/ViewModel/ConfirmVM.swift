//
//  Confirm.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
class Confirm {
    func confirm(OTP:Int,userID:String){
        APIs.genericApiWithPagination(pageNo: 0, url: URLS.confirm, method: .post, paameters: paramter.confirm(otp: OTP, userID: userID), headers: Headers.AccepTTokenHeaders()) { (conf:confirmModel?, err:Error?, code:Int?) in
            if code == 200 {
                if err == nil {
                    
                }
            }
        }
    }
}
    
