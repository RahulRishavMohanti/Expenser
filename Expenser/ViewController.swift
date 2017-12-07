//
//  ViewController.swift
//  Expenser
//
//  Created by Rahul Rishav Mohanti on 17/09/17.
//  Copyright © 2017 Rahul Rishav Mohanti. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Canvas
var x = String()
var y = String()
var bal = ""
var curr_user = String()
var y_name = String()
var y_amt = String()
var y_method = String()
var y_date = String()
class ViewController: UIViewController, UITextFieldDelegate {
    //@IBOutlet weak var checkInView: CSAnimationView!
    @IBOutlet weak var Dollar: CSAnimationView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var Password: UITextField!

    @IBOutlet weak var butt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        butt.layer.cornerRadius = 4
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
    
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
          if(textField == Password)
          {
          ScrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated:true)
        
    }
    
    
    @IBAction func checkIn(_ sender: Any)
    {   //butt.setBackgroundImage(#imageLiteral(resourceName: "tapped"), for: UIControlState.selected)
        print("clicked")
        
        Password.resignFirstResponder()
        Auth.auth().createUser(withEmail: username.text!, password: Password.text!)
        { (user, error) in
            if error != nil
            {
                self.login()
            }
            else
            {
                print("User Created")
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("Expenses").child((user?.uid)!).child("0").updateChildValues(["expense":"Food 200 Cash 6th"])
                ref.child("Balance").updateChildValues([(user?.uid)!:"0"])
                self.login()
            }
        }

    }
    func login(){
        Auth.auth().signIn(withEmail: username.text!, password: Password.text!) { (user, error) in
            if error != nil
            { 
                print("Incorrect Pass")
            }
            else
            {   curr_user = (user?.uid)!
                //print (user?.email ?? "rahul")
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.updateChildValues(["currentUser":user?.uid ?? "none"])
                x = (user?.uid)! as? String ?? ""
                self.Dollar.type = CSAnimationTypeZoomIn
                self.Dollar.duration = 2
                self.Dollar.delay = 0
                self.Dollar.startCanvasAnimation()
                self.performSegue(withIdentifier: "firstSegue", sender: nil)
                    
            
            }
        }
    }
    
}

