//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by atao1 on 1/15/18.
//  Copyright © 2018 atao1. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController{
    
    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var memeDetailImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        //self.imageView!.image =
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
