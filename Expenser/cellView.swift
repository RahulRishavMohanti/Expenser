//
//  cellView.swift
//  Expenser
//
//  Created by Rahul Rishav Mohanti on 16/10/17.
//  Copyright © 2017 Rahul Rishav Mohanti. All rights reserved.
//

import UIKit

class cellView: UIViewController {

    @IBOutlet weak var payMethod: UIImageView!
    @IBOutlet weak var ExpenseName: UILabel!
    @IBOutlet weak var ExpenseAmt: UILabel!
    @IBOutlet weak var ExpenseDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ExpenseName.text = y_name
        ExpenseDate.text = y_date
        ExpenseAmt.text = y_amt
        switch(y_method){
        case "Cash": payMethod.image = UIImage(named: "rupee")!;break
        case "Debit": payMethod.image = UIImage(named: "debit")!;break
        case "Credit": payMethod.image = UIImage(named: "credit")!;break
        case "Cheque": payMethod.image = UIImage(named: "cheque")!;break
        default:  payMethod.image = UIImage(named: "rupee")!; break
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
