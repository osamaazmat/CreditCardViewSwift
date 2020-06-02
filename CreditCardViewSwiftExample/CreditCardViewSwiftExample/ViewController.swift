//
//  ViewController.swift
//  CreditCardViewSwiftExample
//
//  Created by Roamer on 01/06/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import CreditCardViewSwift

class ViewController: UIViewController {

    @IBOutlet weak var creditCardView: CreditCardViewSwift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.delegate = self
    }

}

extension ViewController: CreditCardViewSwiftDelegate {
    func cardDataValidated(name: String, cardNumber: String, cardExpiry: String, cvvNumber: String) {
        print("Card Name: \(name), Card Number: \(cardNumber), Card Expiry: \(cardExpiry), Card CVV Code: \(cvvNumber)")
    }
}

