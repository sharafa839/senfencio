//
//  ProfileVC.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import UIKit
import RxCocoa
import RxSwift
class ProfileVC: UITableViewController {

    @IBOutlet weak var regNumberTF: UITextField!{
        didSet{
            regNumberTF.isEnabled = false
        }
    }
    @IBOutlet weak var companyTf: UITextField!{
        didSet{
            companyTf.isEnabled = false
        }
    }
    @IBOutlet weak var fNameTF: UITextField!{
        didSet{
            fNameTF.isEnabled = false
        }
    }
    @IBOutlet weak var emailTF: UITextField!{
        didSet{
            emailTF.isEnabled = false
        }
    }
    @IBOutlet weak var phoneTF: UITextField!{
        didSet{
            phoneTF.keyboardType = .namePhonePad
            phoneTF.isEnabled = false
        }
    }
    @IBOutlet weak var changePasswordButton: UIButton!{
        didSet{
            changePasswordButton.setTitle("change", for: .normal)
        }
    }
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var registerationNumber: UILabel!{
        didSet{
            registerationNumber.text = "regnumber"
        }
    }
    @IBOutlet weak var companyName: UILabel!{didSet{
        companyName.text = "companyName"
    }}
    @IBOutlet weak var email: UILabel!{
        didSet{
            email.text = "email"
        }
    }
    @IBOutlet weak var firstName: UILabel!{
        didSet{
            firstName.text = "firstName"
        }
    }
    @IBOutlet weak var lastName: UILabel!{
        didSet{
            lastName.text = "lastName"
        }
    }
    @IBOutlet weak var password: UILabel!{
        didSet{
            password.text = "password"
        }
    }
    @IBOutlet weak var passla: UILabel!{
        didSet{
            passla.text = "*******"
        }
    }
    @IBOutlet weak var phoneNumber: UILabel!{
        didSet{
            phoneNumber.text = "phoneNumber"
        }
    }
    @IBOutlet weak var editButton: UIButton!{
        didSet{
            editButton.setTitle("editProfile", for: .normal)
        }
    }
    let profile = Profile()
    let dispose = DisposeBag()
    var isEdit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
       getData()
        subcribeToResponse()
        subscribeToButton()
    }
    
    func getData(){
        if "customer" == "customer"{
            profile.getProfileData(user: .Customer)
        }else{
            profile.getProfileData(user: .Seller)
        }
    }
    func subcribeToResponse()  {
        profile.subscribeToRespnse.subscribe {[weak self] (data) in
            guard let self = self else {return}

            self.fNameTF.text = data.element?.fname
            self.lNameTF.text = data.element?.lname
            self.phoneTF.text = data.element?.phone
            self.email.text = data.element?.email
        }.disposed(by: dispose)

    }
    func editProfile(){
      //  profile.updateData(user: <#T##UserType#>, fname: <#T##String#>, lname: <#T##String#>, phone: <#T##String#>, email: <#T##String#>, crn: <#T##String?#>, company: <#T##String?#>)
    }
    func subscribeToButton(){
        editButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else {return}

            if self.isEdit == false {
                self.isEdit = true
                self.editButton.setTitle("saveChanges", for: .normal)
                self.fNameTF.isEnabled = true
                self.lNameTF.isEnabled = true
                self.phoneTF.isEnabled = true
                self.emailTF.isEnabled = true
                self.changePasswordButton.isHidden = false
                self.companyTf.isEnabled = true
                self.regNumberTF.isEnabled = true


            }else{
                self.isEdit = false
                self.editButton.setTitle("editProfile", for: .normal)
                self.fNameTF.isEnabled = false
                self.lNameTF.isEnabled = false
                self.phoneTF.isEnabled = false
                self.emailTF.isEnabled = false
                self.changePasswordButton.isHidden = true
                self.companyTf.isEnabled = false
                self.regNumberTF.isEnabled = false
                self.editProfile()
            }
        }.disposed(by: dispose)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = indexPath.row
        switch cell {
        case 0:
            return 450
        case 1:
            return 250
        case 2 :
            return 200
        default:
return 0
            
        }
    }}
