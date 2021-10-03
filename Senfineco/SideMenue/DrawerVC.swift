//
//  DrawerVC.swift
//  Arheb
//
//  Created by Mohamed on 8/14/20.
//  Copyright © 2020 Elsheikh. All rights reserved.
//

import UIKit

//enum MenuType: Int {
//    case home
//    case camera
//    case profile
//}

//MARK:- DrawerModel
struct DrawerModel {
    var titleName:String?
    var titleImage:String?
}

class DrawerVC: UIViewController {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var continer: UIView!
    @IBOutlet weak var blankView: UIView!{
        didSet{
            self.blankView.addSwipActionn(vc: self, action: #selector(dissmissAction))
            blankView.addActionn(vc: self, action: #selector(dissmiss))
        }
    }
    @objc func dissmiss(){
        dismiss(animated: true, completion: nil)
    }
    let transiton = SlideInTransition()
let profile = ProfileServices()
    let orderCount = myOrdersVM()
    var NumberOFOrder = Int()
    var myProfilee : ProfileDataPayload?
    var list = [DrawerModel(titleName: "myOrder".localizede, titleImage: "shopping-bag"),
                DrawerModel(titleName: "wallet".localizede, titleImage: "wallet"),
                DrawerModel(titleName: "Favorite".localizede, titleImage: "love"),
                DrawerModel(titleName: "getCredit".localizede, titleImage: "gift"),
                DrawerModel(titleName: "Lang".localizede, titleImage: "global 1"),
                DrawerModel(titleName: "setlocation".localizede, titleImage: "global 1"),
                DrawerModel(titleName: "rateUS".localizede, titleImage: "star"),
                DrawerModel(titleName: "ablut".localizede, titleImage: "doubts-button"),
                DrawerModel(titleName: "terms&condition".localizede, titleImage: "information"),
                DrawerModel(titleName: "logOut".localizede, titleImage: "logout 1")

    ]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        if HelperK.checkUserToken() == true {
       profile.getProfile(vc: self) {[weak self] (myProfile) in
            guard let self = self else {return}
            self.myProfilee = myProfile
        }
        orderCount.getAllOrders(type: HelperK.getType(), vc: self) { (allorders) in
          //  guard let self = self else {return}

            guard let accept = allorders?.payload?.count else {return}
           
            self.NumberOFOrder = accept 
            print(55555,self.NumberOFOrder)
            self.tableView.reloadData()
        }}else{
            
        }
        self.continer.backgroundColor = UIColor.black.withAlphaComponent(1)
        self.continer.addActionn(vc: self, action: #selector(dissmissAction))
        
       
    }
    
    @objc func dissmissAction(){
        //Vibration.light.vibrate()
        self.dismiss(animated: true, completion: nil)

    }

    
    
    
    
  
    
}
extension DrawerVC : UITableViewDelegate, UITableViewDataSource     {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else  {
            return list.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return initTopCell(indexPath: indexPath)
            
        }else {
            return initDrawerCell(indexPath: indexPath)
            
        }
        
    }
    
    
    func  initTopCell(indexPath:IndexPath) -> TopSideMenuCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopSideMenuCell", for: indexPath) as! TopSideMenuCell
        if HelperK.checkUserToken() == true {
            cell.personName.text = HelperK.getname()
            cell.welcomLab.text = HelperK.getemail()
            cell.wallet.text = "Walletr".localizede + "\n" + "\(myProfilee?.walletBalance ?? 000)" + "   SAR".localizede
            cell.ordersNumber.text = "ORDERS".localizede + "\n" + "\(NumberOFOrder)"
            cell.IMAGEPROFILE.downlodImage(str: URLS.main + HelperK.getphoto())
        }else{
            cell.personName.alpha = 0
            cell.welcomLab.alpha = 0
            cell.IMAGEPROFILE.image = UIImage(named: "Ellipse 15")
        }
        return cell
    }
    
    func  initDrawerCell(indexPath:IndexPath) -> DrawerCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerCell", for: indexPath) as! DrawerCell
        cell.titleName.text = list[indexPath.row].titleName
        cell.img.image = UIImage(named: list[indexPath.row].titleImage ?? "")
        if indexPath.row == 9 {
            if HelperK.checkUserToken() == true {
                cell.titleName.text = "Logout".localizede
                cell.titleName.tintColor = .red
            }else{
                cell.titleName.text = "login".localizede
                cell.titleName.tintColor = .init(red: 0, green: 0.36, blue: 0.72, alpha: 1)

            }
        }
        return cell
    }
    
   
    @objc func setActions(tag:Int) {
        Vibration.light.vibrate()
        switch tag {
        case 0 :
            gotoOrders()
        case 1 :
GoToWallet()
        case 2 :
gotoFavss()
        case 3 :
          GoToCrediet()
        case 4 :
            GoToLang()

        case 5:
           
gotosetLocation()
        case 6:
            self.gotorate()
        case 7:
            GoToAbout()

        case 8 :
            GoToterms()

        case 9 :
            LogOut()

        default:
            print("done")
        }
    }
    
    @objc func gotoOrders()  {
        let vc = storyboard?.instantiateViewController(withIdentifier: "myOrders")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .popover
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func gotoFavss()  {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyFavs")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .popover
        self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func GoToWallet(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "wallet")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func GoToCrediet(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "credit")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func GoToAbout(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "about")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func GoToterms(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "terms")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    @objc func GoToLang(){
        let alert = UIAlertController(title: "changeLang".localizede, message: "change".localizede, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "arabic".localizede, style: .default, handler: { (action) in
            if LocalizationManager.shared.getLanguage() == .Arabic{
                UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                LocalizationManager.shared.setLanguage(language: .English)
              
            }else{
                UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                LocalizationManager.shared.setLanguage(language: .Arabic)
               
            }
        }))
        alert.popoverPresentationController?.sourceView = .init()
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func gotosetLocation()  {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "setloc")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func gotorate()  {
        let vc = storyboard?.instantiateViewController(withIdentifier: "rateApp")
        vc?.modalTransitionStyle   = .crossDissolve
        vc?.modalPresentationStyle =  .overFullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func gotoElection()  {
      
    }
    
    @objc func gotoAboutUs(indx:Int)  {
       
    }
    
    
    @objc func gotoPROFILE()  {
       
    }
    
    @objc func gotoGurantee()  {
       
    }
    
    @objc func gotoDewaniahVC()  {
       
    }
    
    
    func LogOut(){
        if HelperK.checkUserToken() == true {
            HelperK.deletUserDefaults()
            let vc = storyboard?.instantiateViewController(withIdentifier: "login")
            present(vc!, animated: true, completion: nil)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "login")
            present(vc!, animated: true, completion: nil)
        }
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 341
        }else {
            if indexPath.row == 5 {
                if HelperK.getType() == "customer" {
                    return 0
                }else{
                    return 45
                }
            }else if indexPath.row == 2 {
                if HelperK.getType() != "customer" {
                    return 0
                }else{
                    return 45
                }
            }
            return 45
        
        }}
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
               self.setActions(tag: indexPath.row)
        }}
    
    
}
extension DrawerVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
