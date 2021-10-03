//
//  HomeVC.swift
//  Senfineco
//
//  Created by ahmed on 9/4/21.
//

import UIKit
import RxCocoa
import RxSwift
class HomeVC: UITableViewController ,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var carGuideButton: UIButton!
    @IBOutlet weak var oilPic: UIImageView!
    @IBOutlet weak var welcomeStatement: UILabel!
    @IBOutlet weak var welcomeSt: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableVieww: UITableView!
    let homeVm = HomeVM()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = nil
        collectionView.dataSource = nil
        getCategory()
        getProduct()
        subscribeToCategoryResponse()
        subscribeToProductResponse()
        subscribeToCategorySelection()
        
    }
    
    // MARK: - Table view data source
    
    @IBAction func scrollLeftButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: 50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func scrollRightButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: -50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func sidemenueButtton(_ sender: UIButton) {
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func getCategory(){
        homeVm.getCategory()
        
    }
    func getProduct(){
        homeVm.getProduct()
        
    }
    func subscribeToCategoryResponse(){
        homeVm.subscribeCategoryResponse.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: HomeCVC.self)){row,data,cell in
            
            cell.configCell(categoty: data)
            
        }.disposed(by: disposeBag)
        
    }
    func subscribeToProductResponse(){
        homeVm.subscribeProductResponse.bind(to: tableVieww.rx.items(cellIdentifier: "cell", cellType: HomeTVC.self)){ row , data ,cell in
            cell.configCell(product: data)
            
        }.disposed(by: disposeBag)
        tableVieww.rowHeight = 230
    }
    func subscribeToCategorySelection(){
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(CategoryPayload.self)).bind { [weak self] selectedIndex,data in
            guard let self = self else {return}
            print(selectedIndex)
            print(data.id)
            self.subscripeToProductByCatID(name: data.categoryNameEn ?? "")
        }.disposed(by: disposeBag)
        
    }
    func subscribeToTableSelection(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(ProductPayload.self)).bind{[weak self] selectedIndex,data in
            // let vc = storyboard?.instantiateViewController(withIdentifier: "ProducteDetailes")
            
        }
    }
    func subscripeToProductByCatID(name:String){
        homeVm.getProductByCategory(productName: name)
    }
    
}
