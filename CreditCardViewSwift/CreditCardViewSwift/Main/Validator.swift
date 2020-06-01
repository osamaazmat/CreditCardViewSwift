//
//  Validator.swift
//  CreditCardViewSwift
//
//  Created by Osama on 29/05/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import Foundation

class Validator {
    
    func isNameValid (_ value: String) -> Bool {
        if value.count > 0 {
            return true
        }
        return false
    }
    
    func isExpiryValid(_ value: String) -> Bool {
        if value.count >= 5 {
            
            let components      = value.split(separator: "/")
            let month           = Int(components.first!) ?? 0
            let year            = Int(components.last!) ?? 0
            let date            = Date()
            let calendar        = Calendar.current
            let currentYear     = calendar.component(.year, from: date)
            let currentMonth    = calendar.component(.month, from: date)
            let yearLastTwo     = currentYear % 100
            
            if month > 12 {
                return false
            }
            else if year == yearLastTwo {
                if month >= currentMonth {
                    return true
                }
                else {
                    return false
                }
            }
            else if year >= yearLastTwo {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    func isCVVOfCardValid(_ value: String) -> Bool {
        if value.count > 1 {
            return true
        }
        return false
    }
    
    func validateCreditCardFormat(_ value: String)-> (type: CardType, valid: Bool) {
        let input = value
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var type: CardType = .Unknown
        var valid = false
        
        if numberOnly.count < 12 || numberOnly.count > 19 {
            return (type, false)
        }
        else {
            // detect card type
            for card in CardType.allCards {
                if (matchesRegex(regex: card.regex, text: numberOnly)) {
                    type = card
                    break
                }
            }
            // check validity
            valid = luhnCheck(number: numberOnly)
            
            // return the tuple
            return (type, valid)
        }
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            guard let digit = Int(tuple.element) else { return false }
            let odd = tuple.offset % 2 == 1
            
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
}
