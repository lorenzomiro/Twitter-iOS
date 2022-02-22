//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Miro on 2/14/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    var liked:Bool = false
    
    var tweetId:Int = -1
    
    var retweeted:Bool = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!

    
    //like function helper for tweets
    @IBAction func like(_ sender: Any) {
        
        let toBeLiked = !liked
        
        if(toBeLiked) {
            
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setIsLiked(true)
                
            }, failure: { (error) in
                print("Like didn't succeed: \(error)")
            })
            
        } else {
            
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setIsLiked(false)
            }, failure: { (error) in
                print("Unlike didn't succeed: \(error)")
            })
            
        }
        
    }
    
    //retweet function helper for retweets
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
            
        }, failure: { (error) in
            
            print("Error in retweeting: \(error)")
            
        })
        
        
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        
        if (isRetweeted) {
            
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            
            retweetButton.isEnabled = false
            
        } else {
            
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            
            retweetButton.isEnabled = true
            
        }
        
    }
    
    func setIsLiked(_ isLiked:Bool) {
        
        liked = isLiked
        
        if (liked) { //switch between liked/unlike status for tweets
            
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            
        } else {
            
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
