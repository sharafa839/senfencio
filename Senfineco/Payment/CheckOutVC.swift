//
//  CheckOutVC.swift
//  Senfineco
//
//  Created by ahmed on 9/11/21.
//

import UIKit

class CheckOutVC: UITableViewController {

    @IBOutlet weak var PlayView: UIView!{
        didSet{
            PlayView.floatView(raduis: 30)
            PlayView.backgroundColor = .black
        }
    }
    @IBOutlet weak var backButtton: UIButton!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var PurchaceCost: UILabel!{
        didSet{
            PurchaceCost.text = "purchaceCost"
        }
    }
    @IBOutlet weak var shippingAddress: UILabel!{
        didSet{
            shippingAddress.text = "shippingAddress"
        }
    }
    @IBOutlet weak var Address: UITextView!{
        didSet{
            Address.isEditable = false
        }
    }
    @IBOutlet weak var totalPrice: UILabel!{
        didSet{
            totalPrice.text = "totalPrice"
        }
    }
    @IBOutlet weak var checkOut: UILabel!{
        didSet{
            checkOut.text = "checkOut"
        }
    }
    @IBOutlet weak var pricee: UILabel!
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.setTitle("Pay", for: .normal)
            payButton.setTitleColor(.white, for: .normal)
        }
    }
    var Pricee = String ()
    var address:AddressModelPayload?
    override func viewDidLoad() {
        super.viewDidLoad()
        pricee.text = Pricee
        Price.text = Pricee
        Address.text = address?.address?.street1
        print(address)
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
