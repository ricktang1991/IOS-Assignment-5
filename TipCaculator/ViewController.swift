//
//  ViewController.swift
//  TipCaculator
//
//  Created by 桑染 on 2020-04-27.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var tipCaculateStackView: UIStackView!
    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipPercentageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipPercentageTextField.delegate = self
        billAmountTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func caculateTip(_ sender: UIButton) {
        var tipAmount: String
        guard !billAmountTextField.text!.isEmpty else {
            return
        }
        if tipPercentageTextField.text!.isEmpty {
            tipAmount = String(Int(billAmountTextField.text!)! * 15 / 100)
        } else {
            tipAmount = String(Int(billAmountTextField.text!)! * Int(tipPercentageTextField.text!)! / 100)
        }
        tipAmountLabel.text = "$ \(tipAmount)"
    }
    
    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        tipPercentageTextField.text = String(Int(sender.value))
        var tipAmount: String
        guard !billAmountTextField.text!.isEmpty else {
            return
        }
        if tipPercentageTextField.text!.isEmpty {
            tipAmount = String(Int(billAmountTextField.text!)! * 15 / 100)
        } else {
            tipAmount = String(Int(billAmountTextField.text!)! * Int(tipPercentageTextField.text!)! / 100)
        }
        tipAmountLabel.text = "$ \(tipAmount)"
    }
    
    @objc func dismissKeyboard(_ recogizer: UITapGestureRecognizer) {
        billAmountTextField.resignFirstResponder()
        tipPercentageTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if view.frame.origin.y != 0 {
                view.frame.origin.y = 0
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

