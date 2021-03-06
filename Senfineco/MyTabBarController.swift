//
//  MyTabBarController.swift
//  Senfineco
//
//  Created by ahmed on 9/15/21.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            setupCenterButton()
        tab.items![0].title = "Home".localizede
        tab.items![1].title = "Ordera".localizede
        tab.items![3].title = "Favorite".localizede
        tab.items![4].title = "Profile".localizede
       
        tab.items![0].selectedImage = UIImage(named: "home")
        tab.items![1].selectedImage = UIImage(named: "orders")
        tab.items![3].selectedImage = UIImage(named: "love")
        tab.items![4].selectedImage = UIImage(named: "user-2")
        tab.items![0].image = UIImage(named: "home-2")
        tab.items![1].image = UIImage(named: "heart")
        tab.items![3].image = UIImage(named: "Vector 348")
        tab.items![4].image = UIImage(named: "user")
        }
    @IBOutlet weak var tab: CustomizedTabBar!
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tabBar.frame.size.height = 60
            tabBar.frame.origin.y = view.frame.height - 60
        }
        
        //MARK: Add button
        func setupCenterButton() {

            let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-23, y: -18, width: 46, height: 46))
            
            middleBtn.backgroundColor = UIColor.borderColor
           middleBtn.setImage(UIImage(named: "cart"), for: .normal)

            middleBtn.layer.cornerRadius = middleBtn.frame.size.height / 2
            
            //add to the tabbar and add click event
            self.tabBar.addSubview(middleBtn)
            middleBtn.addTarget(self, action: #selector(self.CenterButtonAction), for: .touchUpInside)

            self.view.layoutIfNeeded()
        }

        //MARK: center button click event
        @objc func CenterButtonAction(sender: UIButton) {
            self.selectedIndex = 2   // set your index here
        }}



