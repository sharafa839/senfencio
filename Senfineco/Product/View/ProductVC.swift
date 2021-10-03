//
//  ProductVC.swift
//  Senfineco
//
//  Created by ahmed on 9/8/21.
//

import UIKit

class ProductVC: UITableViewController {
    var product:ProductPayload?
    @IBOutlet weak var customView: UIView!{
        didSet{
            customView.floatView(raduis: 20)
        }
    }
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePerUnitLa: UILabel!{
        didSet{
            pricePerUnitLa.text =  "pricePerUnit"
        }
    }
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var desciptionView: UIView!{
        didSet{
            desciptionView.floatView(raduis: 20)
            desciptionView.coloringboder(color: .borderColor)
            desciptionView.layer.borderWidth = 1
            desciptionView.addActionn(vc: self, action: #selector(showdescriptionLabel))
        }
    }
    @IBOutlet weak var desLa: UILabel!{
        didSet{
            desLa.text = "description"
        }
    }
    @IBOutlet weak var howToUseLa: UILabel!{
        didSet{
            howToUseLa.text = "howToUse"
        }
    }
    @IBOutlet weak var expandDesButton: UIButton!{
        didSet{
            expandDesButton.addActionn(vc: self, action: #selector(showdescriptionLabel))
        }
    }
    @IBOutlet weak var expandHowToUseButton: UIButton!{
        didSet{
            expandHowToUseButton.addActionn(vc: self, action: #selector(showUsingLabel))
        }
    }
    @IBOutlet weak var howToUseView: UIView!{
        didSet{
            howToUseView.floatView(raduis: 20)
            howToUseView.addActionn(vc: self, action: #selector(showUsingLabel))
            howToUseView.coloringboder(color: .borderColor)
            howToUseView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var howToUseDes: UILabel!{
        didSet{
            howToUseDes.floatView(raduis: 50)
            howToUseDes.layer.cornerRadius = 10
            howToUseDes.clipsToBounds = true
            howToUseDes.text = "d,a;ld,m;sam,dk;lmfkldsnmbvklmklbmglkfmbklgfmklbmgfklbmgklbmklmgbfkl;mgkl;bmgf;m"
        }
    }
    @IBOutlet weak var descriptionLa: UILabel!{
        didSet{
            descriptionLa.floatView(raduis: 50)
            descriptionLa.layer.cornerRadius = 10
            descriptionLa.clipsToBounds = true
            descriptionLa.text = "d,a;ld,m;sam,dk;lmfkldsnmbvklmklbmglkfmbklgfmklbmgfklbmgklbmklmgbfkl;mgkl;bmgf;m"
        }
    }
    @IBOutlet weak var numberOfUnitsView: UIView!{
        didSet{
            numberOfUnitsView.floatView(raduis: 20)
            numberOfUnitsView.coloringboder(color: .black)
            numberOfUnitsView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var numberofProduct: UILabel!
    @IBOutlet weak var IncreaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var numberOfUnits: UILabel!{
        didSet{
            numberOfUnits.text = "numberOfUnits"
        }
    }
    @IBOutlet weak var addToCartButton: UIStackView!{
        didSet{
            addToCartButton.floatView(raduis: 20)
        }
    }
    @IBOutlet weak var _1: UIButton!{
        didSet{
            _1.tintColor = .gray
        }
    }
    @IBOutlet weak var _2: UIButton!{
        didSet{
            _2.tintColor = .gray
        }
    }
    @IBOutlet weak var _3: UIButton!{
        didSet{
            _3.tintColor = .gray
        }
    }
    @IBOutlet weak var _4: UIButton!{
        didSet{
            _4.tintColor = .gray
        }
    }
    @IBOutlet weak var _5: UIButton!{
        didSet{
            _5.tintColor = .gray
        }
    }
    var numberOfUnit = 1
    var isDesHide = false
    var isUseHide = false

    override func viewDidLoad() {
        super.viewDidLoad()

        ProductImage.downlodImage(str: product?.image ?? "")
        productName.text = product?.title
        priceLabel.text = "\(product?.price ?? 0000)" + "  OMR"
      //  descriptionLa.text = product?.descriptionEn
        rate(rating: product?.rate ?? 000)
        numberofProduct.text = "\(numberOfUnit)"
hideDescriptionLa()
        hideUseLa()
    }
    @IBAction func increase(_ sender: UIButton) {
        numberOfUnit += 1
        numberofProduct.text = "\(numberOfUnit)"

    }
    @IBAction func decrease(_ sender: UIButton) {
        if numberOfUnit == 1 {
            
        }else{
            numberOfUnit -= 1
            numberofProduct.text = "\(numberOfUnit)"
        }}
    @IBAction func favButtonn(_ sender: UIButton) {
        
    }
    @objc func showdescriptionLabel(){
        if isDesHide == false {
        desciptionView.backgroundColor = .borderColor
        descriptionLa.backgroundColor = .borderColor
        animatingDescriptionLa()
        }else{
            hideDescriptionLa()
        }
    }
    @objc func showUsingLabel(){
        if isUseHide == false {
        howToUseView.backgroundColor = .borderColor
        howToUseDes.backgroundColor = .borderColor
animatingUseLa()
            
        }else{
hideUseLa()
            
        }
    }
    func hideDescriptionLa(){
        isDesHide = false
        desciptionView.backgroundColor = .white
        expandDesButton.setImage(UIImage(named: "plus-circle"), for: .normal)

        descriptionLa.isHidden = true
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        descriptionLa.transform = scaleDownTransorm
   
    }
    func hideUseLa(){
        isUseHide = false
        howToUseView.backgroundColor = .white

        expandHowToUseButton.setImage(UIImage(named: "plus-circle"), for: .normal)

        howToUseDes.isHidden = true
        let scaleDownTransorm = CGAffineTransform(scaleX: 0, y: 0)
        howToUseDes.transform = scaleDownTransorm
   
    }
    func animatingDescriptionLa(){
        isDesHide = true
        descriptionLa.isHidden = false
        expandDesButton.setImage(UIImage(named: "minus-circle"), for: .normal)
       // confirmPassTF.isHidden = false
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.descriptionLa.transform = .identity
            }
            
        }
    }
    func animatingUseLa(){
        isUseHide = true
        expandHowToUseButton.setImage(UIImage(named: "minus-circle"), for: .normal)

        howToUseDes.isHidden = false
       // confirmPassTF.isHidden = false
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.howToUseDes.transform = .identity
            }
            
        }
    }
    // MARK: - Table view data source

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func favButton(_ sender: UIButton) {
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

  
}

extension ProductVC {
    func rate(rating:Int){
        switch rating {
        case 0:
            print("")
            ratings.text = "havenorating"
            
        case 1:
            _1.tintColor = .systemYellow
            ratings.text = "1StarRating"
        case 2:
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            ratings.text = "2StarRating"
            
        case 3 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            ratings.text = "3StarRating"
            
        case 4 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            _4.tintColor = .systemYellow
            ratings.text = "4StarRating"
            
        case 5 :
            _1.tintColor = .systemYellow
            _2.tintColor = .systemYellow
            _3.tintColor = .systemYellow
            _4.tintColor = .systemYellow
            _5.tintColor = .systemYellow
            ratings.text = "5StarRating"
            
        default:
            print("")
        }
    }
}
