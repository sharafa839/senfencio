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
            titleLa.text = "Filter"
        }
    }
    @IBOutlet weak var recomended: UIButton!{
        didSet{
            recomended.setTitle("viewRecomed", for: .normal)
            recomended.floatButton(raduis: 20)
        }
    }

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var makeTableView: UITableView!
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var modelTableView: UITableView!
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
        getData()
        subscribeToResponse()
        selectType()
        subscribeToButton()
    }
    func getData(){
        filter.FetchData()
        
    }
    func selectType(){
        Observable.zip(makeTableView.rx.itemSelected, makeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.make = data
        }.disposed(by: disposeBag)
        
        
        Observable.zip(modelTableView.rx.itemSelected, modelTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.model = data
            
        }.disposed(by: disposeBag)
        
        Observable.zip(typeTableView.rx.itemSelected, typeTableView.rx.modelSelected(String.self)).bind{[weak self]selectedUndex,data in
            guard let self = self else {return}

            self.type = data
            
        }.disposed(by: disposeBag)
        
    }
    func subscribeToButton() {
        guard !model.isEmpty else {
            modelTableView.shakeF()
            return
        }
        guard !make.isEmpty else {
            makeTableView.shakeF()
            return
        }
        guard !type.isEmpty else {
            typeTableView.shakeF()
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "result") as! RecomendedVC
        vc.make = make
        vc.model = model
        vc.type = type
        self.present(vc, animated: true, completion: nil)
        
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
