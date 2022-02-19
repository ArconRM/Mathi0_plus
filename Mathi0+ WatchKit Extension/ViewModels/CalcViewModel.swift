//
//  ViewModels.swift
//  Mathi0+ WatchKit Extension
//
//  Created by Artemiy Mirotvortsev on 06.02.2022.
//

import Foundation
import SwiftUI

final class CalcViewModel: ObservableObject {
    
    @Published var currentNumber: Decimal = 0.0
    @Published var a: Decimal = 0.0
    @Published var b: Decimal = 0.0
    @Published var wasOperationPressed: Bool = false
    @Published var isOperationPressed: Bool = false
    @Published var resultText: String = "0"
    @Published var operationText: String = ""
    @Published var wasCommaPressedInThisNumber: Bool = false
    
    
    func Digits(item: CalcButtons) {
        if (resultText != "inf") {
            if (resultText.count < 18) || (isOperationPressed == true){
                if resultText == "0" {
                    resultText = ""
                }
                if resultText == "-0" {
                    resultText = String(resultText.dropLast())
                }
                if (isOperationPressed == false) {
                    resultText += item.rawValue
                }
                if (isOperationPressed == true) {
                    isOperationPressed = false
                    wasOperationPressed = true
                    resultText = ""
                    resultText = resultText + item.rawValue
                    wasCommaPressedInThisNumber = false
                }
                if ((resultText.contains(".")) == true) {
                    wasCommaPressedInThisNumber = true
                }
            }
            currentNumber = Decimal(string: resultText.replacingOccurrences(of: " ", with: ""))!
        }
        if resultText == "inf" {
            resultText = "Error"
        }
    }
    
    func Operations(item: CalcButtons) {
        if (resultText != "inf") {
            if (wasOperationPressed == false) && (isOperationPressed == false) {
                isOperationPressed = true
                a = currentNumber
                currentNumber = 0
            } else if (wasOperationPressed == true) && (isOperationPressed == false) {
                isOperationPressed = true
                b = currentNumber
                switch operationText {
                case "+":
                    resultText = "\(a+b)"
                case "-":
                    resultText = "\(a-b)"
                case "*":
                    resultText = "\(a*b)"
                case "/":
                    resultText = "\(a/b)"
                default:
                    return
                }
                a = Decimal(string: resultText)!
                b = 0.0
                currentNumber = 0.0
            } else {
                a = currentNumber
            }
            switch item {
            case .divide:
                operationText = "/"
            case .multiply:
                operationText = "*"
            case .subtract:
                operationText = "-"
            case .add:
                operationText = "+"
            default:
                operationText = "Er"
            }
        }
        if resultText == "inf" {
            resultText = "Error"
        }
        if ((resultText.contains(".")) == true) {
            wasCommaPressedInThisNumber = true
        }
        if isEndingDotZero(str: resultText) == true {
            resultText = String(resultText.dropLast())
            resultText = String(resultText.dropLast())
        }
    }
    
    func Equal(item: CalcButtons) {
        if (resultText != "inf") && (resultText != "nan") && (resultText != "Error") {
            if (wasOperationPressed == true) && (isOperationPressed == false) {
                b = currentNumber
                switch operationText {
                case "+":
                    resultText = "\(a+b)"
                case "-":
                    resultText = "\(a-b)"
                case "*":
                    resultText = "\(a*b)"
                case "/":
                    resultText = "\(a/b)"
                default:
                    return
                }
                a = Decimal(string: resultText)!
                b = 0.0
                currentNumber = a
                operationText = ""
            }
            isOperationPressed = true
            if (resultText.last == "0") && (String((resultText.dropLast())).last == ".") {
                resultText = String(resultText.dropLast())
                resultText = String(resultText.dropLast())
            }
        }
        if resultText == "inf" || resultText == "nan" {
            resultText = "Error"
        }
        if ((resultText.contains(".")) == true) {
            wasCommaPressedInThisNumber = true
        }
        if isEndingDotZero(str: resultText) == true {
            resultText = String(resultText.dropLast())
            resultText = String(resultText.dropLast())
        }
    }
    
    func NumberChange(item: CalcButtons) {
        if (resultText != "inf") && (resultText != "nan") && (resultText != "Error") {
            switch item {
            case .percent:
                resultText = String(currentNumber.doubleValue/100)
            case .comma:
                if (wasCommaPressedInThisNumber == false) && (resultText.count < 11) {
                    resultText = resultText + "."
                }
                wasCommaPressedInThisNumber = true
            case .negative:
                resultText = "\(-currentNumber)"
            case .factorial:
                if isStringAnInt(string: resultText) == true {
                    resultText = factorial(a: Decimal(string: resultText)!)
                } else {
                    resultText = "Error"
                }
            case .cube:
                resultText = _pow(a: currentNumber, k: 3)
            case .square:
                resultText = _pow(a: currentNumber, k: 2)
            case .sqrt:
                if currentNumber < 0 {
                    resultText = "Error"
                } else {
                    resultText = "\(_sqrt(number: currentNumber))"
                }
            default:
                resultText = "Error"
            }
            if (resultText != "-") && (resultText != "inf") && (resultText != "Error") && (resultText != "nan")  {
                currentNumber = Decimal(string: resultText.replacingOccurrences(of: " ", with: "")) ?? 0
            }
        }
        if resultText == "inf" || resultText == "nan" {
            resultText = "Error"
        }
        if ((resultText.contains(".")) == true) {
            wasCommaPressedInThisNumber = true
        }
        if isEndingDotZero(str: resultText) == true {
            resultText = String(resultText.dropLast())
            resultText = String(resultText.dropLast())
        }
        
    }
    
    func Solve(item: CalcButtons) {
        
        switch item {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            Digits(item: item)
        case .clear:
            resultText = "0"
            operationText = ""
            a = 0.0
            b = 0.0
            currentNumber = 0.0
            wasOperationPressed = false
            isOperationPressed = false
            wasCommaPressedInThisNumber = false
        case .sqrt, .square, .cube, .comma, .factorial, .negative, .percent:
            NumberChange(item: item)
        case .divide, .add, .subtract, .multiply:
            Operations(item: item)
        case .equal:
            Equal(item: item)
        }
    }
    
    
    func defineColor(item: CalcButtons) -> Color {
        var color: Color
        switch item {
        case .clear, .sqrt, .square, .cube, .factorial, .percent, .negative:
            color = .white
                .opacity(0.6)
        case .divide, .multiply, .subtract, .add, .equal:
            color = .blue.opacity(0.6)
        default:
            color = .gray.opacity(0.6)
        }
        return color
    }
    
    func defineFontSize() -> Int {
        switch resultText.count {
        case ...10:
            return 25
        case 11...16:
            return 35 - resultText.count
        default:
            return 25
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
        if Double(GetFraction(a: "\(number)").count).truncatingRemainder(dividingBy: 2) == 0 {
            a = a * pow(10, GetFraction(a: "\(number)").count)
            b = a.intValue
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
        return numberToReturn / pow(10, GetFraction(a: "\(number)").count / 2)
    }
    
    func GetFraction(a: String) -> String {
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
    
    func isEndingDotZero(str: String) -> Bool {
        if (str.last == "0") && (str.dropLast().last == ".") && (str != "") {
            return true
        } else {
            return false
        }
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    func _pow(a: Decimal, k: Int) -> String {
        var b: Decimal = 1
        for _ in 1...k {
            b = b*a
        }
        if k == 0 {
            return "1"
        } else if k == 1 {
            return "\(a)"
        } else {
            return "\(b)"
        }
    }
    
    func factorial(a: Decimal) -> String {
        let a1: Int = a.intValue
        var b: Decimal = 1
        if (a1 > 1) {
            for i in 1...a1 {
                b = b * Decimal(i)
            }
        }
        if a1 == 0 {
            return "1"
        } else {
            return "\(b)"
        }
    }
}



extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
    var intValue: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
    func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .bankers) -> Decimal {
        var result = Decimal()
        var number = self
        NSDecimalRound(&result, &number, 0, roundingMode)
        return result
    }
    var whole: Int { (self < 0 ? rounded(.up) : rounded(.down)).intValue }
    var fraction: Decimal { self - Decimal(whole) }
    var negativeValue: Decimal {
        return -(NSDecimalNumber(decimal: self) as Decimal)
    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension Double {
    var whole: Int { Int((self < 0 ? rounded(.up) : rounded(.down))) }
}
