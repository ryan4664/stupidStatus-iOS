//
//  ViewController.swift
//  stupidStatusApp
//
//  Created by Ryan Donohue on 2016-12-17.
//  Copyright © 2016 Ryan Donohue. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var currentStatus: UILabel!
    
    @IBAction func getNewStatus(_ sender: Any) {
        getStatus()
    }
    @IBOutlet weak var bannerAd: GADBannerView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TEST
        //bannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //PROD
        bannerAd.adUnitID = "ca-app-pub-2784831729284923/8946119498"
        bannerAd.rootViewController = self
        bannerAd.load(GADRequest())
        getStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStatus() -> Void {
        
        let url = URL(string: "http://stupidstat.us/api/user/status")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let status = json["text"]
                
                DispatchQueue.main.async(execute: {
                    self.currentStatus.text  = status! as! String
                })
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        
        task.resume()

    }


}

