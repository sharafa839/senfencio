//
//  LoginVC.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa
class LoginVC: UIViewController {
let disposeBag = DisposeBag()
    
    @IBOutlet weak var signInLa: UILabel!
    @IBOutlet weak var phoneTF: UITextField!{
        didSet{
            phoneTF.placeholder = "phone"
            phoneTF.floatView(raduis: 10)
            phoneTF.drawBorder(raduis: 10, borderColor:     .black)
            phoneTF.layer.borderWidth = 1
            phoneTF.placeHolderColor(color: .gray)
            phoneTF.keyboardType = .namePhonePad
}}
    @IBOutlet weak var passTF: UITextField!{
        didSet{
            passTF.placeholder = "password"
            passTF.floatView(raduis: 15)
            passTF.drawBorder(raduis: 10, borderColor:     .black)
            passTF.layer.borderWidth = 1
            passTF.placeHolderColor(color: .gray)
            passTF.isSecureTextEntry = true
}}
    @IBOutlet weak var visabilityButton: UIButton!{
        didSet{
            visabilityButton.tintColor = .black
        }}
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.floatButton(raduis: 30)
            loginButton.setTitle("signIn", for: .normal)
        }}
    @IBOutlet weak var InfoLa: UILabel!{
        didSet{
            InfoLa.text = "ifudon'thave"
        }}
    @IBOutlet weak var registerVcButton: UIButton!{
        didSet{
            registerVcButton.setTitle("signup", for: .normal)
        }}
    let login=loginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextFieldToViewModel()
subscribeToLoginButton()
        subscripeToVisabilityButton()
    }
    func bindTextFieldToViewModel() {
        phoneTF.rx.text.orEmpty.bind(to: login.phone).disposed(by: disposeBag)
        passTF.rx.text.orEmpty.bind(to: login.password).disposed(by: disposeBag)
         }
    func subscribeToLoginButton() {
        loginButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[weak self] (_) in
                guard let self = self else{return}
                self.login.login(vc: self)
            }.disposed(by: disposeBag)
    }
    func subscripeToVisabilityButton(){
        visabilityButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] (_) in
                guard let self = self else{return}
                self.passTF.isSecureTextEntry = !self.passTF.isSecureTextEntry
            }.disposed(by: disposeBag)
    }
}
