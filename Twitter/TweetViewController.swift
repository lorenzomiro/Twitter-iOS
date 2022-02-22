//
//  TweetViewController.swift
//  Twitter
//
//  Created by Miro on 2/15/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextView.becomeFirstResponder() //get cursor + text view connected to tweet button
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        //set up cancel feature
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        
        if (!tweetTextView.text.isEmpty) {
            
            //post tweet if there's something in the tweet text view
            
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet: \(error)")
                
                self.dismiss(animated: true, completion: nil)
            })
            
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
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
