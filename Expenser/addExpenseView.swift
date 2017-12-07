//
//  addExpenseView.swift
//  Expenser
//
//  Created by Rahul Rishav Mohanti on 18/10/17.
//  Copyright © 2017 Rahul Rishav Mohanti. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class addExpenseView: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var payMethod: UIPickerView!
    @IBOutlet var expense_name: UITextField!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var expense_amt: UITextField!
    var array = ["Cash","Debit","Credit","Cheque"]
    var payM = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    payMethod.delegate = self
    payMethod.dataSource = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == expense_amt || textField == expense_name)
        {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated:true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payM = array[row]
    }
    
    
    @IBAction func addExp(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd_MM_yyyy"
        let result = formatter.string(from: date)

        var final = expense_name.text! + " " + expense_amt.text! + " " + payM + " " + result
        print(final)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Expenses").child(curr_user).child(expense_name.text!).updateChildValues(["expense":final])
       
        ref.child("Balance").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var prevBal = Int(value?[x] as? String ?? "")
            prevBal = prevBal! - Int(self.expense_amt.text!)!
            var fbal = String(prevBal!)
            ref.child("Balance").updateChildValues([x:fbal ?? " "])
            self.performSegue(withIdentifier: "addSegue", sender: nil)
        }) { (error) in
            print(error.localizedDescription)
        }

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
