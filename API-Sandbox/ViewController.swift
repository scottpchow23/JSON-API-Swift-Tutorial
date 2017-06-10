//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        exerciseOne()
        exerciseTwo()
        exerciseThree()
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    self.movie = Movie(json: json["feed"]["entry"][Int(arc4random_uniform(24))])
                    self.movieTitleLabel.text = self.movie?.name
                    self.rightsOwnerLabel.text = self.movie?.rightsOwner
                    self.releaseDateLabel.text = self.movie?.releaseDate
                    self.priceLabel.text = "$\(self.movie?.price ?? 0.00)"
                    if let posterLink = self.movie?.poster {
                        self.loadPoster(urlString: posterLink)
                    } else {
                        print("Couldn't get the poster link.")
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    func loadPoster(urlString: String) {
        if let url = URL(string: urlString) {
            posterImageView.af_setImage(withURL: url)
        } else {
            print("Bad url.")
        }
        
    }
    
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
        if let link = movie?.link {
            if let url = URL(string: link) {
                UIApplication.shared.openURL(url)
            } else {
                print("Malformed url.")
            }
            print("Couldn't get the link to the movie.")
        }
        
    }
    
}

