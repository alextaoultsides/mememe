//
//  ViewController.swift
//  MemeMe
//
//  Created by atao1 on 12/14/17.
//  Copyright © 2017 atao1. All rights reserved.
//

import UIKit
import Foundation

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let memeTextDelegate = MemeTextfieldDelegate()
    var sentMeme: Meme!
    var sentMemeIndex: Int!
    
    @IBOutlet weak var originalMemeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4.0,]
    
    
    // MARK: Load textfields and set defaults
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTextFieldSetup(memeTextField: topTextfield)
        memeTextFieldSetup(memeTextField: bottomTextfield)
        memeTextDefault()
        editedMeme()
        
    }
    func memeTextDefault(){
        topTextfield.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        
    }
    //MARK: Edit meme setup
    func editedMeme(){
        if self.sentMeme?.originalImage != nil{
            originalMemeImage.image = self.sentMeme.originalImage
            topTextfield.text = self.sentMeme.topText
            bottomTextfield.text = self.sentMeme.bottomText
        }
        
    }
    
    func editSentMeme(memeOld: Meme, memeIndex: Int){
        self.sentMeme = memeOld
        self.sentMemeIndex = memeIndex
    }
    
    func memeTextFieldSetup(memeTextField: UITextField){
        
        memeTextField.delegate = memeTextDelegate
        memeTextField.defaultTextAttributes = memeTextAttributes
        memeTextField.textAlignment = NSTextAlignment.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)//Checks if camera is available and enables camera button
    }

    // MARK: Toolbar buttons
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePickerDevice(device: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePickerDevice(device: .photoLibrary)
    }
    
    func imagePickerDevice(device: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = device
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            originalMemeImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Save Completed Meme
    func save() {
        // Create the meme
        let meme = Meme.init(topText: topTextfield.text!, bottomText: bottomTextfield.text!, originalImage: originalMemeImage.image!, memedImage: generateMemedImage()  )
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        if sentMeme == nil{
            
            appDelegate.memes.append(meme)
        }
        else{
            appDelegate.memes[sentMemeIndex] = meme
        }
        
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hides bars for screenshot
        setBars()
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //bars become visible after screenshot is taken
        setBars()
        
        
        return memedImage
    }
    
    func setBars(){
        toolBar.isHidden = !toolBar.isHidden
        navBar.isHidden = !navBar.isHidden
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK:  Notifications
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
   
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextfield.text == ""){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    // MARK: Action Button for Activity View Controller
    @IBAction func shareButton(_ sender: Any) {
        
        let controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
            if self.originalMemeImage.image != nil{
                self.save()
                return
            }
        }
    }
    
    
    // MARK: Cancel Button resets Meme if not already in memes array
    @IBAction func cancelButton(_ sender: Any) {
        print("cancelButton pressed")
        if self.sentMeme == nil{
        memeTextDefault()
        originalMemeImage.image = nil
        self.dismiss(animated: true, completion: nil)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   
    
    
}

