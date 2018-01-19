//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by atao1 on 1/15/18.
//  Copyright © 2018 atao1. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memes = appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memes = appDelegate.memes
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell")!
        let sentMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = sentMeme.topText
        cell.imageView?.image = sentMeme.memedImage
        
        print("goodbye")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailView") as! MemeDetailViewController
        //detailController.memeDetailImageView.image = self.memes[(indexPath as NSIndexPath).row].memedImage
        print(indexPath.row)
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}
