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
    var meme: Meme!
    var memeIndex: Int! //current meme row index
    
    @IBOutlet weak var memeDetailImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeDetailImageView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(EditMeme)
        )
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //send meme to meme editor
    @objc func EditMeme(){
        
        let editMemeController = self.storyboard!.instantiateViewController(withIdentifier: "editMemeVC") as! MemeViewController
        let memeNew = self.meme
        editMemeController.editSentMeme(memeOld: memeNew!, memeIndex: memeIndex)
        self.present(editMemeController, animated: true, completion: nil)
    }
    
    
}
