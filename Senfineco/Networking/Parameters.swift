//
//  Parameters.swift
//  Store Joud
//
//  Created by ahmed on 6/14/21.
//

import Foundation
import Alamofire
class paramter {
    let shared = paramter()
    class func registerParms(email:String,phone:String,name:String,password:String,type:String)->Parameters{
        let parms = ["email":email,
                     "phone":phone,
                     "full_name":name,
                     "password":password, "type":type] as [String:Any]
        return parms
    }
    class func registerProviderParms(email:String,phone:String,name:String,password:String,type:String,workfields:String,nationality:String)->Parameters{
        let parms = ["email":email,
                     "phone":phone,
                     "full_name":name,
                     "password":password, "type":type,
                     "work_fields[]":workfields,
                     "nationality":nationality] as [String:Any]
        return parms
    }
    class func LoginParms (phone:String,password:String)->Parameters {
        let parms = ["phone":phone,
        "password":password] as [String:Any]
        return parms
    }
    class func updateLocation (lat:Double,lon:Double)->Parameters {
        let parms = ["lat":lat,
        "lng":lon] as [String:Any]
        return parms
    }
    class func Lang(language:String)->Parameters {
        let parms = ["lang":language] as [String:Any]
        return parms
    }
    class func updateName(language:String)->Parameters {
        let parms = ["full_name":language] as [String:Any]
        return parms
    }
    class func updatePhone(language:String)->Parameters {
        let parms = ["phone":language] as [String:Any]
        return parms
    }
    class func updateEmail(language:String)->Parameters {
        let parms = ["email":language] as [String:Any]
        return parms
    }
    class  func AdreessParms(name: String,street:String,phone:String,city:String,postalCode:String,country:String) ->Parameters {
        let parms = ["name":name,
                     "phone":phone,
                     "street_name":street,
                     "city":city,
                     "postal_code":postalCode,
                     "country":country] as [String:Any]
        return parms
    }
    class func updateAdressParms(addressID:String,blockNumber:String)->Parameters {
        let parms = ["address_id"  : addressID,
        "block_number" : blockNumber] as [String:Any]
        return parms
    }
    class func updateLogoParms (logo:UIImage)->Parameters {
        let parms = ["logo":logo] as [String:Any]
        return parms
    }
    class func updateProfileParms (name:String,email:String,phone:String)->Parameters {
        let parms = ["full_name":name,
                     "email":email,
                     "phone":phone] as [String:Any]
        return parms
    }
    class func updatePasswordParms(password:String,email:String)->Parameters {
        let parms = ["password":password,
        "email":"email"] as [String:Any]
    return parms
    }
    class func sendContactMessageParms(phone:String,email:String,message:String,name:String)->Parameters {
        let parms = ["phone":phone,
                     "email":email,
                     "message":message,
                     "name":name] as [String:Any]
        return parms
        
    }
    class func ReviewParms(rate:Int,review:String) ->Parameters {
        let parms = ["rate":rate,
        "review":review] as [String:Any]
        return parms
    }
    
    class func updateQuantityParms(updateQuantity:String)->Parameters {
        let parms = ["update_quantity":updateQuantity] as [String:Any]
        return parms
    }
    class func promoCodeParms(Code:String)->Parameters {
        let parms = ["promo_code":Code] as [String:Any]
        return parms
    }
    
    class  func newOrdersParms(description:String,service_id:String,lat:Double,lon:Double,address:String,time:String,date:String)->Parameters {
        let parms = ["description"     : description ,
                     "service_id"        : service_id,
                     "lat"     : lat,
                     "lng" : lon ,
                     "address": address,
                     "time":time,
                     "date":date] as [String:Any]
        return parms
    }
    class  func newOrderswithCodeParms(description:String,service_id:String,lat:Double,lon:Double,address:String,time:String,date:String,promoCode:String)->Parameters {
        let parms = ["description"     : description ,
                     "service_id"        : service_id,
                     "lat"     : lat,
                     "lng" : lon ,
                     "address": address,
                     "time":time,
                     "date":date,
                     "promo_code":promoCode] as [String:Any]
        return parms
    }
    
    
    class func trackOrderParms(invoiceID:String)-> Parameters{
        let parms = ["invoice_id":invoiceID] as [String:Any]
        return parms
    }
    
    
    class  func searchParms(withKey:String,recently:String,popular:String,priceHigh:String,priceLow:String,priceFrom:String,priceTo:String)->Parameters {
        let parms = ["price_from":priceFrom,
                     "price_to":priceTo,
                     "price_low":priceLow,
                     "price_high":priceHigh,
                     
                     "most_popular":popular,
                     
                     "most_recently":recently,
                     
                     "search_with_key":withKey
        ] as [String:Any]
        
        return parms
    }
    
    
    
    
    
    
    
    
}
