//
//  RegisterSeller.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import UIKit
import MaterialComponents
import RxSwift
import RxCocoa
class RegisterSellerVC: UIViewController {

    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 15)
        }
    }
    @IBOutlet weak var signUp: UILabel!{
        didSet{
            signUp.text = "signUp"
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.addActionn(vc: self, action: #selector(back))
        }
    }
    @IBOutlet weak var fNameTF: MDCOutlinedTextField!{
        didSet{
            fNameTF.label.text = "firstName"
            fNameTF.setOutlineColor(.borderColor, for: .normal)
            fNameTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var lNameTF: MDCOutlinedTextField!{
        didSet{
            lNameTF.label.text = "lastName"
            lNameTF.setOutlineColor(.borderColor, for: .normal)
            lNameTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var registerationNumber: MDCOutlinedTextField!{
        didSet{
            registerationNumber.label.text = "registerationNumber"
            registerationNumber.setOutlineColor(.borderColor, for: .normal)
            registerationNumber.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var companyTF: MDCOutlinedTextField!{
        didSet{
            companyTF.label.text = "company"
            companyTF.setOutlineColor(.borderColor, for: .normal)
            companyTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    
    @IBOutlet weak var emailTF: MDCOutlinedTextField!{
        didSet{
            emailTF.label.text = "email"
            emailTF.setOutlineColor(.borderColor, for: .normal)
            emailTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var phoneTF: MDCOutlinedTextField!{
        didSet{
            phoneTF.label.text = "phone"
            phoneTF.keyboardType = .phonePad
            phoneTF.setOutlineColor(.borderColor, for: .normal)
            phoneTF.setOutlineColor(.borderColor, for: .editing)


        }
    }
    @IBOutlet weak var passTF: MDCOutlinedTextField!{
        didSet{
            passTF.label.text = "pass"
            passTF.isSecureTextEntry = true
            passTF.setOutlineColor(.borderColor, for: .normal)
            passTF.setOutlineColor(.borderColor, for: .editing)

        }
    }
    @IBOutlet weak var signUPButton: UIButton!{
        didSet{
            signUPButton.setTitle("signUp", for: .normal)
            signUPButton.setTitleColor(.gray, for:.disabled)
            signUPButton.floatButton(raduis: 30)
        }
    }
    @IBOutlet weak var infoLa: UILabel!{
        didSet{
            infoLa.text = "ifuhaveacc"
        }
    }
    @IBOutlet weak var signInButton: UIButton!{
        didSet{
            signInButton.setTitle("signIn", for: .normal)
        }
    }
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }
    let registerVm  = SellerViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
      //  subscribeToIsSignUpButtonEnabled()
        subscribeToSignupButton()
        subscribeToResponse()
    }
    func bindTextField(){
        fNameTF.rx.text.orEmpty.bind(to: registerVm.firstName).disposed(by: disposeBag)
        lNameTF.rx.text.orEmpty.bind(to: registerVm.lastName).disposed(by: disposeBag)
        emailTF.rx.text.orEmpty.bind(to: registerVm.email).disposed(by: disposeBag)
        passTF.rx.text.orEmpty.bind(to: registerVm.password).disposed(by: disposeBag)
        phoneTF.rx.text.orEmpty.bind(to: registerVm.phone).disposed(by: disposeBag)
        companyTF.rx.text.orEmpty.bind(to: registerVm.company).disposed(by: disposeBag)
        registerationNumber.rx.text.orEmpty.bind(to: registerVm.registerationNumber).disposed(by: disposeBag)

    }
    func checkValidat(){
        
      
        guard let fName = fNameTF.text , !fName.isEmpty else {
            fNameTF.shakeF()
            return
        }
        guard  let lName = lNameTF.text ,!lName.isEmpty else {
            lNameTF.shakeF()
            return
        }
        guard  let email  = emailTF.text , !email.isEmpty else {
            emailTF.shakeF()
            return
        }
        guard  let phone  = phoneTF.text , !phone.isEmpty else {
            phoneTF.shakeF()
            return
        }
        guard  let pass = passTF.text , !pass.isEmpty else {
            passTF.shakeF()
            return
        }
    }
    func subscribeToSignupButton()  {
        signUPButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance).subscribe {[weak self] (_) in
            guard let self = self else {return}
            self.checkValidat()
            self.registerVm.register()
        }.disposed(by: disposeBag)
}
    func subscribeToIsSignUpButtonEnabled() {
        registerVm.isSignUpButtonIsEnabled.bind(to: signUPButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        registerVm.observableRegisterModel.subscribe { (data) in
            guard let payload = data.element?.payload else {
                return
            }
            if data.element?.code == 200 {
                HelperK.showSuccess(title: data.element?.message ?? "", subtitle: "")
                
                HelperK.setUserData(phone: payload.phone ?? "", name: payload.fname! + payload.lname! , image: "", email: payload.email ?? "", code: "")
                
            }else{
                HelperK.showError(title:data.element?.message ?? "" , subtitle: "")
            }
        }.disposed(by: disposeBag)

    }

}
