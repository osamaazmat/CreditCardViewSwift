//
//  SkyFloatingLabel+Ext.swift
//  CreditCardViewSwift
//
//  Created by Osama on 29/05/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    
    func showError(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func hideError() {
        self.errorMessage = ""
    }
    
    func makeAutoCapitalized() {
        self.autocapitalizationType = .words
    }
    
}
