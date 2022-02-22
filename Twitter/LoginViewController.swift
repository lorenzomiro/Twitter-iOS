//
//  LoginViewController.swift
//  Twitter
//
//  Created by Miro on 2/14/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true { //if user logged in, take them to home screen
            
            //log in
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
        }
        
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        //set up API URL connection
        
        let API_URL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: API_URL, success: { //log in successful?
            
            //save login status
            UserDefaults.standard.setValue(true, forKey: "userLoggedIn")
            
            //log in
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { Error in
            print("Log in failed.") //show failed login
        })
    }
    

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
