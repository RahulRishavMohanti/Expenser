//
//  TVC.swift
//  
//
//  Created by Rahul Rishav Mohanti on 08/10/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class TVC: UITableViewController {    
    var ref: DatabaseReference!
    var refHandle = UInt()
    var refHandle2 = UInt()
    var expenseList = [User]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print("hey");
        fetchFinance()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func fetchFinance(){
        print("fetchFinance called");
        refHandle = ref.child("Expenses").child(x).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]
            {   print(dictionary)
                print("hey")
                let user = User()
                user.setValuesForKeys(dictionary)
                self.expenseList.append(user)
                print(self.expenseList[0].expense ?? "x")
                DispatchQueue.main.async() {
                    print("hey2")
                    
                    self.tableView.reloadData()
                }

            }
        })
        ref.child("Balance").observe(.value, with: { (snap) in
            let value = snap.value as? NSDictionary
            bal = value?[x] as? String ?? ""
            DispatchQueue.main.async() {
                print("hey2")
                
                self.tableView.reloadData()
            }
        })
        
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenseList.count+1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       /* let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        // Set Cell Contents
        y = expenseList[indexPath.row].expense!
        var temp = y.characters.split{$0 == " "}.map(String.init)

        cell.textLabel?.text = temp[0] + " " + temp[1]*/
        if(indexPath.row>0)
        {
        let cell = Bundle.main.loadNibNamed("tvcell", owner: self, options: nil)?.first as! tvcell
        y = expenseList[indexPath.row-1].expense!
        var temp = y.characters.split{$0 == " "}.map(String.init)
        
        cell.labelexpense.text! = temp[0] + " " + temp[1]
        
            return cell
        }
        else{
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            y = "Balance:" + bal
            cell.textLabel?.text = y;
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row>0)
        {
        y = expenseList[indexPath.row-1].expense!
        var yarr = y.characters.split{$0 == " "}.map(String.init)
        y_name = yarr[0]
        y_amt = yarr[1]
        y_method = yarr[2]
        y_date = yarr[3]
        self.performSegue(withIdentifier: "seguecell", sender: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "addBalSeg", sender: nil)
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
