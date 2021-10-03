//
//  URLS.swift
//  Store Joud
//
//  Created by ahmed on 6/14/21.
//

import Foundation
class URLS {
    static let main = "https://4napp.com"
    static let login = main + "/api/login"
    static let register = main + "/api/register"
    static let logout = main + "/api/logout"
    static let updatePassword = main + "/api/forget/password/new"
    static let services = main + "/api/services"
    static let getProvidersInLocation = main + "/api/orders/"
    static let updateLocation = main + "/api/profile/update/location"
    static let AccomplisheOrder = main + "/api/"
    static let addNewAddress = main + "/api/user/addresses"
    static let allAdress = main + "/api/user/addresses"
    static let updateAddress = main + "/api/user/addresses/update"
    static let deleteAddress = main + "/api/user/addresses/destroy/"
    static let getNotification = main + "/api/orders/notifications"
    static let getNotificationByID = main + "/api/orders/notifications/{{\(String.self)}}"
    static let deliverdOrders = main + "/api/customer/profile/orders/delivered"
    static let activeOrders = main + "/api/"
    static let profile = main + "/api/profile"
    static let updateProfileLogo = main + "/api/profile/update/logo"
    static let updateProfilePassword = main + "/api/profile/update/password"
    static let updateProfile =  main + "/api/profile/update"
    static let generalList = main + "/api/general"
    static let sendContactMessage = main + "/api/contacts"
    static let makeThisProudctFav = main + "/api/products/"
    static let markAsFavorite = main + "/api/providers/"
    static let listAllFavs = main + "/api/providers/favorites"
    static let removeThisProductFromFav = main + "/api/products/"
    static let markAsUnFavorite = "/api//mark-as-un-favorite"
    static let addReview = main + "/api/providers/"
    static let submitReview = "/api/rate-us/submit-review"
    static let getAllReviews = main + "/api/products/"
    static let reviews = "/api/reviews"
    static let fetchAllProducts = main + "/api/products"
    static let fetchTopselling = fetchAllProducts + "/top-selling?lang="
    static let fetchTopRated = fetchAllProducts + "/top-rated?lang="
    static let fetchOffres = fetchAllProducts + "/offers"
    static let fetchProductByID = fetchAllProducts + "/"
    static let banner = main + "/api/banners"
    static let addToCart = fetchAllProducts + "/"
    static let cart = main + "/api/cart"
    static let GetAllCar = main + "/api/cart"
    static let removeSingleProductFromCart = GetAllCar + "/destroy/"
    static let updateQuantatyOfProductInCart = GetAllCar + "/"
    static let update = main + "/api/cart/"
    static let promoCode = main + "/api/promo-codes/check"
    static let makeNewOrder = main + "/api/services/order"
    static let markAsPaid = main + "/api/orders//mark-as-paid"
    static let cancelOrder = main + "/api/orders/cancel-request-by-provider/"
    static let acceptOrder = main + "/api/orders/"

    static let trackOrder = main + "/api/order/tracking"
    static let listAllCat = main + "/api/categories?lang="
static let listspecificCat = main + "/api/categories/"
    static let listnearbyCategories = listspecificCat
    static let products = "/api//products"
    static let listAllBrands = main + "/api/brands"
    static let readSpecificBrand = listAllBrands + "/"
    static let listAllBrandProducts = readSpecificBrand
    static let search = main + "/api/search"
    
    static let review = main + "/api/products/"

    
    
    
    
    

    
    
    
    
    
    
}
