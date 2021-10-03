//
//  HomeVC.swift
//  Senfineco
//
//  Created by ahmed on 9/4/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
class HomeVC: UITableViewController ,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var carGuideButton: UIButton!{
        didSet{
            carGuideButton.setTitle("carGuide".localizede, for: .normal)
        }
    }
    @IBOutlet weak var oilPic: UIImageView!
    @IBOutlet weak var welcomeStatement: UILabel!{
        didSet{
            welcomeStatement.text = "hi ".localizede + HelperK.getname()
        }
    }
    @IBOutlet weak var welcomeSt: UILabel!{
        didSet{
            welcomeSt.text = "Welcome to our shop".localizede
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var tableVieww: UITableView!
    let homeVm = HomeVM()
    let product = ProductVM()
    let transiton = SlideInTransition()

    let disposeBag = DisposeBag()
    var dataSource : RxTableViewSectionedReloadDataSource<productsSection>?
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = RxTableViewSectionedReloadDataSource.init(configureCell: {[weak self] (dataSourcse, tablView, indexPath,Item)   in

            tablView.rowHeight = 210
            let cell = tablView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVC
            cell.configCell(product: Item)
            cell.addProductButton.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}

                self.product.AddToCart(productId: Item.id ?? "", quantity: 1, customer: true, vc: self)
            }.disposed(by: self?.disposeBag ?? DisposeBag())
           

            return cell
            
        })

        collectionView.delegate = nil
        collectionView.dataSource = nil
        getCategory()
        getProduct()
        subscribeToCategoryResponse()
        subscribeToProductResponse()
        subscribeToCategorySelection()
        subscribeToTableSelection()
        carGuidePerson()
    }
    
    // MARK: - Table view data source
    func carGuidePerson(){
        carGuideButton.rx.tap.subscribe { [weak self]_ in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "filter")
            self.present(vc!, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        

    }
    @IBAction func scrollLeftButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: +50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func scrollRightButton(_ sender: UIButton) {
        collectionView.setContentOffset(CGPoint(x: -50, y:0), animated: true)
        print(collectionView.contentOffset)
    }
    @IBAction func sidemenueButtton(_ sender: UIButton) {
        GoToDrawer()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    @IBAction func carguideButton(_ sender: UIButton) {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
        
    
    func getCategory(){
        homeVm.getCategory(vc: self)
        
    }
    func getProduct(){
        homeVm.getProduct(vc: self)
        
    }
    func subscribeToCategoryResponse(){
        homeVm.subscribeCategoryResponse.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: HomeCVC.self)){row,data,cell in
            cell.cellShadowWithCornerRadius(color: .borderColor, opacity: 0.05, radius: 10, edge: .All, shadowSpace: 0.1, cornerRadius: 15)
            cell.configCell(categoty: data)
            //cell.sizeToFit()
            cell.coloringboder(color: .borderColor)
            cell.layer.borderWidth = 0.5
        }.disposed(by: disposeBag)
        
    }
    func subscribeToProductResponse(){
        homeVm.subscribeProductResponse.map({ produst in
            [productsSection(headers: "", items: produst)]
        }).bind(to: tableVieww.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        tableVieww.rowHeight = 230
    }
    func subscribeToCategorySelection(){
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(CategoryPayload.self)).bind { [weak self] selectedIndex,data in
            guard let self = self else {return}
            print(selectedIndex)
            print(data.categoryNameEn)
            self.subscripeToProductByCatID(name: data.categoryNameEn ?? "")
        }.disposed(by: disposeBag)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.frame
        return CGSize(width: cell.size.width, height: cell.size.height)
    }
    func subscribeToTableSelection(){
        Observable.zip(tableVieww.rx.itemSelected, tableVieww.rx.modelSelected(ProductPayload.self)).bind{[weak self] selectedIndex,data in
            guard let self = self else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProducteDetailes") as!  ProductVC
            vc.product = data
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    func subscripeToProductByCatID(name:String){
        homeVm.specialCallApi(productName: name, vc: self)
    }
    
}
extension HomeVC: UIViewControllerTransitioningDelegate {
    
    
    @objc func GoToDrawer(){
        guard let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrawerVC") as? DrawerVC else { return }
        menuViewController.modalPresentationStyle = .overFullScreen
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
   /*
    @objc func GoToCart(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC") as? CartVC else { return }
        vc.modalTransitionStyle   = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func GoToNotifications(){
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        vc.modalTransitionStyle   = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    private func initBottomView(model:homeModel) {
        let vc = ProductContentVC()
        vc.modalPresentationStyle = .custom
        vc.isHome = true
        vc.recModel = model
        self.present(vc, animated: true, completion: nil)
    }
    */
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
