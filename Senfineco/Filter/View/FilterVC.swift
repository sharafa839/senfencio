//
//  FilterVC.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class FilterVC: UITableViewController {
    @IBOutlet weak var titleLa: UILabel!{
        didSet{
            titleLa.text = "Filter".localizede
        }
    }
    @IBOutlet weak var recomended: UIButton!{
        didSet{
            recomended.setTitle("viewRecomed".localizede, for: .normal)
            recomended.floatButton(raduis: 20)
        }
    }

    @IBOutlet weak var chooseYourCar: UILabel!{
        didSet{
            chooseYourCar.text = "choose your car".localizede
        }
        
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var makeTableView: UITableView!{
        didSet{
            makeTableView.floatView(raduis: 15)
            makeTableView.coloringboder(color: .borderColor)
            makeTableView.layer.borderWidth = 0.8
        }
    }
    @IBOutlet weak var typeTableView: UITableView!{
        didSet{
            typeTableView.floatView(raduis: 15)
            typeTableView.coloringboder(color: .borderColor)
            typeTableView.layer.borderWidth = 0.8
        }
    }
    @IBOutlet weak var modelTableView: UITableView!{
        didSet{
            modelTableView.floatView(raduis: 15)
            modelTableView.coloringboder(color: .borderColor)
            modelTableView.layer.borderWidth = 0.8
        }
    }
    @IBOutlet weak var carModel: UILabel!{
        didSet{
            carModel.text = "carModel".localizede
        }
    }
    @IBOutlet weak var typeButton: UIButton!{
        didSet{
            typeButton.setTitle("chooseType", for: .normal)
            typeButton.floatButton(raduis: 15)
            typeButton.coloringboder(color: .borderColor)
            typeButton.setTitleColor(.black, for: .normal)
            typeButton.layer.borderWidth = 0.8
            typeButton.backgroundColor = .white
        }
        
    }
    
    @IBOutlet weak var makeButtonn: UIButton!
    @IBOutlet weak var makeButton: UIButton!{
        didSet{
            makeButton.setTitle("chooseMake", for: .normal)
            makeButton.floatButton(raduis: 15)
            makeButton.coloringboder(color: .borderColor)
            makeButton.setTitleColor(.black, for: .normal)
            makeButton.layer.borderWidth = 0.8
            makeButton.backgroundColor = .white
        }
        
    }
  
    @IBOutlet weak var ModelButton: UIButton!{
        didSet{
            ModelButton.setTitle("chooseModel", for: .normal)
            ModelButton.floatButton(raduis: 15)
            ModelButton.coloringboder(color: .borderColor)
            ModelButton.setTitleColor(.black, for: .normal)
            ModelButton.layer.borderWidth = 0.8
            ModelButton.backgroundColor = .white
        }
        
    }
    func modelButtonSubscribe(){
        ModelButton.rx.tap.subscribe { _ in
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.modelTableView.isHidden =  !self.modelTableView.isHidden
                }
            }
            print("model")

        }.disposed(by: disposeBag)

    }
    func typeButtonSubscribe(){
        typeButton.rx.tap.subscribe { (_) in
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.typeTableView.isHidden =  !self.typeTableView.isHidden
                }
            }
            print("type")
        }.disposed(by: disposeBag)

    }
   
    @IBOutlet weak var carType: UILabel!{
        didSet{
            carType.text = "carType".localizede
        }
    }
    @IBOutlet weak var carTtpe: UILabel!{
        didSet{
            carTtpe.text = "carTtpe".localizede
        }
    }
    func dismss(){
        backButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)

    }
    var dataSource1 : RxTableViewSectionedReloadDataSource<filterSection>?
    var dataSource2 : RxTableViewSectionedReloadDataSource<filterSection>?
    var dataSource3 : RxTableViewSectionedReloadDataSource<filterSection>?
let filter = Filter()
    var model = String()
    var type = String()
    var make = String()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTableView.isHidden = true
        modelTableView.isHidden = true
        makeTableView.isHidden = true
        
        dataSource1 = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = Item
            return cell
            
        })
        dataSource2 = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
            cell.textLabel?.text = Item


            return cell
            
        })
        dataSource3 = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = Item

            return cell
            
        })
        dismss()
        getData()
        subscribeToResponse()
        selectType()
        subscribeToButton()
        makeButtonSubscribe()
        typeButtonSubscribe()
        modelButtonSubscribe()
       
    }
    func getData(){
        filter.FetchData(vc: self)
        
    }
 func makeButtonSubscribe(){
        makeButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            self.makeButton.secAnimation()
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.makeTableView.isHidden =  !self.makeTableView.isHidden
                }
            }
        }.disposed(by: disposeBag)

    }
    func selectType(){
       Observable.zip(makeTableView.rx.itemSelected, makeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.make = data
            self.makeButton.setTitle(self.make, for: .normal)

        }.disposed(by: disposeBag)
        
        
        Observable.zip(modelTableView.rx.itemSelected, modelTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.model = data
            self.ModelButton.setTitle(self.model, for: .normal)

        }.disposed(by: disposeBag)
        
       Observable.zip(typeTableView.rx.itemSelected, typeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.type = data
            self.typeButton.setTitle(self.type, for: .normal)
        }.disposed(by: disposeBag)
        
    }
    func subscribeToButton() {
        recomended.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}
            self.recomended.secAnimation()
            guard !self.model.isEmpty else {
                self.modelTableView.shakeF()
                return
            }
            guard !self.make.isEmpty else {
                self.makeTableView.shakeF()
                return
            }
            guard !self.type.isEmpty else {
                self.typeTableView.shakeF()
                return
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "result") as! RecomendedVC
            vc.make = self.make
            vc.model = self.model
            vc.type = self.type
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)

        
       
        
    }
    func subscribeToResponse(){
        filter.subscribeToRespons.map ({ SectionMode  in
            [filterSection(header: "", items: SectionMode.make ?? [String].init())]
        
        }).bind(to: makeTableView.rx.items(dataSource: dataSource1!)).disposed(by: disposeBag)
        
       filter.subscribeToRespons.map ({ SectionMode  in
            [filterSection(header: "", items: SectionMode.type ?? [String].init())]
        
        }).bind(to: typeTableView.rx.items(dataSource: dataSource2!)).disposed(by: disposeBag)
       filter.subscribeToRespons.map ({ SectionMode  in
            [filterSection(header: "", items: SectionMode.model ?? [String].init())]
        
        }).bind(to: modelTableView.rx.items(dataSource: dataSource3!)).disposed(by: disposeBag)
 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
