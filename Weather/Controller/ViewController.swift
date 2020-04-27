//
//  ViewController.swift
//  Weather
//
//  Created by Fernanda Dias on 24/04/20.
//  Copyright © 2020 Fernanda Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
        return true
        }
        else {
            textField.placeholder = "Type Something"
        return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
}

