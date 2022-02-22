//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Miro on 2/14/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    //create an array of tweets
 
    var tweetArray = [NSDictionary]()
 
    var numTweets: Int!
    
    //refresh control setup
    
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTweets() //get the tweets
        
        //refresh to target
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl
        
        //change cell height to automatically calculate
        
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.estimatedRowHeight = 150
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.loadTweets()
        
        
        
    }
    
    @objc func loadTweets() {
        
        numTweets = 20
        
        //create URL to be passed
        
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        //get 10 tweets
        
        let params = ["count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: params, success: { (tweets: [NSDictionary]) in
            
            //clear tweet array
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                
                //add tweet to array
                
                self.tweetArray.append(tweet)
            
            }
            
            self.tableView.reloadData()
            
            print("loadTweets()")
            
            print("\(self.tweetArray)")
            
            self.myRefreshControl.endRefreshing()
            
        }, failure: { Error in
            print("Couldn't retrieve Tweets. :(")
        })
        
    }
    
    //help load more tweets using infinite scrolling
    
    func loadMoreTweets() {
        
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numTweets = numTweets + 20
        
        let params = ["count": numTweets]
        
        //retrieve tweets similar to loadTweets
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: params, success: { (tweets: [NSDictionary]) in
            
            //clear tweet array
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                
                //add tweet to array
                
                self.tweetArray.append(tweet)
            
            }
            
            self.tableView.reloadData()
            
            self.myRefreshControl.endRefreshing()
            
        }, failure: { Error in
            print("Couldn't retrieve Tweets. :(")
        })
        
        
        
    }
    
    //screen @ the end? load more tweets
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell //cast tewettable view as a tweet tableview cell
        
        //fetch tweets (tweet + username) from Twitter API
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.usernameLabel.text = user["name"] as? String
        
        
        cell.tweetContentLabel.text = (tweetArray[indexPath.row]["text"] as? String)
        
        //get image data
        
        let imgURL = URL(string: (user["profile_image_url_https"] as? String)!)
        
        let data = try? Data(contentsOf: imgURL!)
        
        
        if let imageData = data {
            
            cell.profileImageView.image = UIImage(data: imageData)
            
        }
        
        //toggle like button if tweet is liked or not
        
        cell.setIsLiked(tweetArray[indexPath.row]["favorited"] as! Bool)
        
        //fetch tweet ID for data
        
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        cell.retweeted = tweetArray[indexPath.row]["retweeted"] as! Bool
        
        //set retweeted
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }

    

}
