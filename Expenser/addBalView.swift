//
//  addBalView.swift
//  Expenser
//
//  Created by Rahul Rishav Mohanti on 09/11/17.
//  Copyright © 2017 Rahul Rishav Mohanti. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class addBalView: UIViewController {

    @IBOutlet var balVal: UITextField!
    @IBAction func setBalance(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Balance").updateChildValues([(x):balVal.text ?? 0])
            
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
