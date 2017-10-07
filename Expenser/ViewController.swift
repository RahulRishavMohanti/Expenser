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
class ViewController: UIViewController, UITextFieldDelegate {
    var x=""
    @IBOutlet weak var checkInView: CSAnimationView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var Password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
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
          if(textField == Password && textField.isFirstResponder)
          {
          ScrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated:true)
        
    }
    
    
    @IBAction func checkIn(_ sender: Any)
    {
        checkInView.type=CSAnimationTypeZoomOut
        checkInView.startCanvasAnimation()
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
                self.login()
            }
        }

    }
    func login(){
        Auth.auth().signIn(withEmail: username.text!, password: Password.text!) { (user, error) in
            if error != nil
            {   self.checkInView.type = CSAnimationTypeShake
                self.checkInView.duration = 1
                self.checkInView.startCanvasAnimation()
                print("Incorrect Pass")
            }
            else
            {   //print (user?.email ?? "rahul")
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.updateChildValues(["currentUser":user?.uid ?? "none"])
                
                 self.performSegue(withIdentifier: "firstSegue", sender: nil)
                ref.child("NameFromUID").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    print(value)
                    self.x = value?[(user?.uid)!] as? String ?? ""
                    print (self.x)
                    print ("Huzzah")
                    
                    self.performSegue(withIdentifier: "firstSegue", sender: nil)
                    
                    
                })
                { (error) in
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
}

