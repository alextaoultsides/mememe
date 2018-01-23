//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by atao1 on 1/15/18.
//  Copyright © 2018 atao1. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCell", for: indexPath) as! SentMemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        
        cell.memedImageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.memes = appDelegate.memes
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailView") as! MemeDetailViewController
        let meme = self.memes[indexPath.row]
        detailController.meme = meme
        
        
        
        self.navigationController!.pushViewController(detailController, animated: true)    }
}
