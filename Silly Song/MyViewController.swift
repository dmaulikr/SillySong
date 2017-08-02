//
//  MyViewController.swift
//  Silly Song
//
//  Created by Jeff on 7/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    @IBAction func showAlertNoName() {
        
        // create the alert
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a name.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        
        //should I be checking for a blank nameField here or handle it in the lyricsForName method?
        if nameField.text!.characters.count > 0{
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }else{
            showAlertNoName()
        }
    }
    
    
}


// MARK: - UITextFieldDelegate
extension MyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


private func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    //var fullName = fullName
    let shortName = shortNameForName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return String(lyrics)
}
private func shortNameForName(name: String) -> String {
    
    var str = ""
    let index = name.lowercased().characters.index { "aeiou".characters.contains($0) }
    
    if(index != nil){
        str = name.substring(from: index!).lowercased()
    } else{
        str = name.lowercased()
    }
    
    
    return String(str.characters)
    
}










