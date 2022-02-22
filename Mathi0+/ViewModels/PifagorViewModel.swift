//
//  PifagorViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 19.02.2022.
//

import Foundation
import SwiftUI

final class PifagorViewModel: ObservableObject {
    
    @Published var showChooseView: Bool = true
    @Published var showGipotView: Bool = false
    @Published var showCatetView: Bool = false
    @Published var showKeyboard: Bool = false
    
    @Published var aText: String = "0"
    @Published var bText: String = "0"
    @Published var cText: String = "0"
    @Published var resultText: String = ""
    @Published var selectedTextField: textFields = .no
    
    func getFraction(a: String) -> String {
        var aStr = a
        let k: Int = aStr.count-1
        
        for _ in 0...k {
            if aStr[0] == "." {
                aStr = String(aStr.dropFirst())
                break
            } else {
                aStr = String(aStr.dropFirst())
            }
        }
        
        return aStr
    }
    
    func _pow(a: Decimal, k: Int) -> Decimal {
        var b: Decimal = 1
        for _ in 1...k {
            b = b*a
        }
        if k == 0 {
            return 1
        } else if k == 1 {
            return a
        } else {
            return b
        }
    }
    
    func _sqrt(number: Decimal) -> Decimal {
        var a: Decimal = number
        var b: Int = 0
        var power: Int = 0
        var factor: Int = 2
        var numberToReturn: Decimal = 1.0
        
        if number == 0 {
            return 0
        }
        if Double(getFraction(a: "\(number)").count).truncatingRemainder(dividingBy: 2) == 0 {
            a = a * pow(10, getFraction(a: "\(number)").count)
            b = a.int
            while b > 1 {
                while b % factor == 0 {
                    b = b / factor
                    power += 1
                }
                if power != 0 {
                    if Double(power).truncatingRemainder(dividingBy: 2) == 0 {
                        numberToReturn = numberToReturn * pow(Decimal(factor), (power / 2))
                    } else {
                        return Decimal(sqrt(number.doubleValue))
                    }
                }
                power = 0
                factor += 1
            }
        } else {
            return Decimal(sqrt(number.doubleValue))
        }
        return numberToReturn / pow(10, getFraction(a: "\(number)").count / 2)
    }
    
    func Clear() {
        aText = "0"
        bText = "0"
        cText = "0"
        resultText = ""
        selectedTextField = .no
    }
    
    func SolveGip() {
        var a: Decimal = 0
        var b: Decimal = 0
        
        if (aText != "") && (bText != "") && (aText != "√") && (bText != "√") {
            
            if (aText.contains("√") == true) {
                a = Decimal(string: String(aText.dropFirst()))!
            } else {
                a = _pow(a: Decimal(string: aText)!, k: 2)
            }
            
            if (bText.contains("√") == true) {
                b = Decimal(string: String(bText.dropFirst()))!
            } else {
                b = _pow(a: Decimal(string: bText)!, k: 2)
            }
            
            if "\(_sqrt(number: a+b))".count <= 6 {
                resultText = "Hypotenuse" + " = \(_sqrt(number: a+b))"
            } else {
                resultText = "Hypotenuse" + " = √\(a+b)"
            }
        }
    }
    
    func SolveCath() {
        var a: Decimal = 0
        var c: Decimal = 0
        var text: String = ""
        
        if (aText != "") && (cText != "") && (aText != "√") && (cText != "√")  {
            
            if (aText.contains("√") == true) {
                a = Decimal(string: String(aText.dropFirst()))!
            } else {
                a = _pow(a: Decimal(string: aText)!, k: 2)
            }
            
            if (cText.contains("√") == true) {
                c = Decimal(string: String(cText.dropFirst()))!
            } else {
                c = _pow(a: Decimal(string: cText)!, k: 2)
            }
            
            if a > c {
                text = cText
                cText = aText
                aText = text
                
                if (aText.contains("√") == true) {
                    a = Decimal(string: String(aText.dropFirst()))!
                } else {
                    a = _pow(a: Decimal(string: aText)!, k: 2)
                }
                
                if (cText.contains("√") == true) {
                    c = Decimal(string: String(cText.dropFirst()))!
                } else {
                    c = _pow(a: Decimal(string: cText)!, k: 2)
                }
            }
            if "\(_sqrt(number: c-a))".count <= 6 {
                resultText = "Cathetus" + " = \(_sqrt(number: c-a))"
            } else {
                resultText = "Cathetus" + " = √\(c-a)"
            }
        }
    }
}
