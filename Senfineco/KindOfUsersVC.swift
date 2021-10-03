//
//  KindOfUsersVC.swift
//  Senfineco
//
//  Created by ahmed on 9/15/21.
//

import UIKit

class KindOfUsersVC: UIViewController {
    @IBOutlet weak var kind: UILabel!{
        didSet{
            kind.text = "kind".localizede
        }
    }
   
    @IBOutlet weak var arab: UIStackView!{
        didSet{
            arab.floatView(raduis: 10)
            arab.clipsToBounds = true
            arab.layer.borderWidth = 0.5
            arab.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    @IBOutlet weak var eng: UIStackView!{
    didSet{
        eng.floatView(raduis: 10)
        eng.clipsToBounds = true
        eng.layer.borderWidth = 0.5
        eng.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
    @IBOutlet weak var engLangButton: UIButton!{
        didSet{
            engLangButton.setTitle("seller".localizede, for: .normal)
            engLangButton.addTarget(self, action:  #selector(chooseLanguage), for: .touchUpInside)
            
        }
    }
   
    @IBOutlet weak var arabLangButton: UIButton!{
        didSet{
            arabLangButton.setTitle("client".localizede, for: .normal)
            arabLangButton.addTarget(self, action:  #selector(chooseLanguage1), for: .touchUpInside)
            arabLangButton.layer.cornerRadius = 10
            arabLangButton.clipsToBounds = true

        }
    }
    @IBOutlet weak var sellerImage: UIImageView!{
        didSet{
            sellerImage.addActionn(vc: self, action: #selector(chooseLanguage))
        }
    }
    
    @IBOutlet weak var clientImage: UIImageView!{
        didSet{
            clientImage.addActionn(vc: self, action: #selector(chooseLanguage1))
        }
    }
    @objc func chooseLanguage(){
        eng.backgroundColor = .init(red: 0.960, green: 0.550, blue: 0.120, alpha: 1)
        eng.layer.borderWidth = 0

        arab.backgroundColor = .clear
        arabLangButton.setTitleColor(.init(red: 0, green: 0.31, blue: 0.62, alpha: 1), for: .normal)
        eng.floatView(raduis: 15)
        eng.setRoundCorners(15)
        engLangButton.setTitleColor(.white, for: .normal)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sellerReg") as! RegisterSellerVC
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    @objc func chooseLanguage1(){
        arab.layer.borderWidth = 0

        arab.backgroundColor = .init(red: 0.960, green: 0.550, blue: 0.120, alpha: 1)
        eng.backgroundColor = .clear
        engLangButton.setTitleColor(.init(red: 0, green: 0.31, blue: 0.62, alpha: 1), for: .normal)
        arabLangButton.setTitleColor(.white, for: .normal)
        arab.floatView(raduis: 15)
        arab.setRoundCorners(15)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "clientReg") as! RegisterClientVC
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    //    print(HelperK.getUserToken())
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
