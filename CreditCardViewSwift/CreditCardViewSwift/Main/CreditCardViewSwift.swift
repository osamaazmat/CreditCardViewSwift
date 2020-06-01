//
//  CreditCardViewSwift.swift
//  TestCustomViewNib
//
//  Created by Osama on 31/05/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

public protocol CreditCardViewSwiftDelegate {
    func cardDataValidated(name: String, cardNumber: String, cardExpiry: String, cvvNumber: String)
}

@IBDesignable public class CreditCardViewSwift: UIView {
    
    var view: UIView!   
    
    @IBOutlet weak var nameOnCardTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cardNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cardExpirationTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cvvTextField: SkyFloatingLabelTextField!
    
    @IBInspectable
    public var namePlaceHolder: String = "Your Name" {
        didSet {
            self.nameOnCardTextField.placeholder = self.namePlaceHolder
        }
    }
    
    @IBInspectable
    public var numPlaceHolder: String = "Card Number" {
        didSet {
            self.cardNumberTextField.placeholder = self.namePlaceHolder
        }
    }
    
    @IBInspectable
    public var expPlaceHolder: String = "Card Expiry" {
        didSet {
            self.cardExpirationTextField.placeholder = self.namePlaceHolder
        }
    }
    
    @IBInspectable
    public var cvvPlaceHolder: String = "CVV" {
        didSet {
            self.cvvTextField.placeholder = self.namePlaceHolder
        }
    }
    
    var nameOnCard: String      = ""
    var cardNumber: String      = ""
    var cardExpiry: String      = ""
    var cvvNumber: String       = ""
    
    public var delegate: CreditCardViewSwiftDelegate?
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        bringSubviewToFront(view)
        
        nameOnCardTextField.makeAutoCapitalized()
        cardNumberTextField.keyboardType = .numberPad
        cardExpirationTextField.keyboardType = .numberPad
        cvvTextField.keyboardType = .numberPad
        
        nameOnCardTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cardNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cardExpirationTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cvvTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CreditCardViewSwift", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1 {
            self.nameOnCard = textField.text!
        }
        else if textField.tag == 2 {
            self.cardNumber = textField.text!
        }
        else if textField.tag == 3 {
            self.cardExpiry = textField.text!
        }
        else if textField.tag == 4 {
            self.cvvNumber = textField.text!
        }
        
        let isValid = validate()
        
        if isValid {
            if let delegate = self.delegate {
                delegate.cardDataValidated(name: self.nameOnCard, cardNumber: self.cardNumber, cardExpiry: self.cardExpiry, cvvNumber: self.cvvNumber)
            }
        }
    }
    
    func validate() -> Bool {
        if Validator().isNameValid(nameOnCard) {
            nameOnCardTextField.hideError()
            let creditCardValidationInfo = Validator().validateCreditCardFormat(cardNumber)
            if creditCardValidationInfo.valid {
                cardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
                cardNumberTextField.hideError()
                if Validator().isExpiryValid(self.cardExpiry) {
                    self.cardExpirationTextField.hideError()
                    if Validator().isCVVOfCardValid(self.cvvNumber) {
                        self.cvvTextField.hideError()
                        return true
                    }
                    else {
                        self.cvvTextField.showError(errorMessage: CreditCardFieldType.cardCVV.rawValue)
                        return false
                    }
                }
                else {
                    self.cardExpirationTextField.showError(errorMessage: CreditCardFieldType.cardExpiry.rawValue)
                    return false
                }
            }
            else {
                self.cardNumberTextField.showError(errorMessage: CreditCardFieldType.cardNumber.rawValue)
                return false
            }
        }
        else {
            self.nameOnCardTextField.showError(errorMessage: CreditCardFieldType.cardName.rawValue)
            return false
        }
    }
    
}

extension CreditCardViewSwift: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 {
            let input = textField.text ?? ""
            let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var formatted = ""
            // format
            var formatted4 = ""
            for character in numberOnly {
                if formatted4.count == 4 {
                    formatted += formatted4 + " "
                    formatted4 = ""
                }
                formatted4.append(character)
            }
            formatted += formatted4 // the rest
            
            textField.text = formatted
        }
        if textField.tag == 3 {
            if range.length > 0 {
                return true
            }
            if string == "" {
                return false
            }
            if range.location > 4 {
                return false
            }
            var originalText = textField.text
            let replacementText = string.replacingOccurrences(of: " ", with: "")
            
            //Verify entered text is a numeric value
            if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: replacementText)) {
                return false
            }
            
            //Put / after 2 digit
            if range.location == 2 {
                originalText?.append("/")
                textField.text = originalText
            }
            return true
        }
        else {
            return true
        }
    }
}
