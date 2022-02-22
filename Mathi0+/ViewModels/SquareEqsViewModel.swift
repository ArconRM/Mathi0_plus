//
//  SquareEqsViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 13.02.2022.
//

import Foundation
import SwiftUI

enum textFields {
    case no
    case a
    case b
    case c
}

final class SquareEqsViewModel: ObservableObject {
    var aStr: String = "0", bStr: String = "0", cStr: String = "0"
    var d: Decimal = 0.0, b2: Decimal = 0.0
    var sqrtD: String = "", strx1: String = "", strx2: String = ""
    
    @Published var aText = "0"
    @Published var bText = "0"
    @Published var cText = "0"
    @Published var resultText = ""
    
    @Published var selectedTextField: textFields = .no
    
    func _sqrt(number: Decimal) -> Decimal {
        var a: Decimal = number
        var b: Int = 0
        var power: Int = 0
        var factor: Int = 2
        var numberToReturn: Decimal = 1.0
        
        if number == 0 {
            return 0
        }
        if Double(GetFraction(a: number).count).truncatingRemainder(dividingBy: 2) == 0 {
            a = a * pow(10, GetFraction(a: number).count)
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
        return numberToReturn / pow(10, (GetFraction(a: number)).count / 2)
    }
    
    func GetFraction(a: Decimal) -> String {
        var aStr: String = "\(a)"
        if (aStr == "NaN") {
            return "Error"
        }
        
        if aStr.first == "-" {
            aStr = String(aStr.dropFirst())
        }
        
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
    
    func digits(text: textFields) {
        switch text {
        case .no:
            return
        case .a:
            selectedTextField = .a
        case .b:
            selectedTextField = .b
        case .c:
            selectedTextField = .c
        }
    }
    
    func Clear() {
        aText = "0"
        bText = "0"
        cText = "0"
    }
    
    func Solve() {
        aStr = aText
        bStr = bText
        cStr = cText
        if (aText != "") && (bText != "") && (cText != "") && (aText != "-") && (bText != "-") && (cText != "-") {
            if aText == "-" {
                aText = "-1"
            }
            if bText == "-" {
                bText = "-1"
            }
            if cText == "-" {
                cText = "-1"
            }
            
            let a:Decimal = Decimal(string: aStr)!, b:Decimal = Decimal(string: bStr)!, c:Decimal = Decimal(string: cStr)!
            let a2:Decimal = 2*a
            var d: Decimal = 0.0
            var x1: Decimal = 0.0, x2: Decimal = 0.0
            var x1Fraction: String = "", x2Fraction: String = "" //дробная часть
            
            for _ in 1...2 {
                
                if ((a == 0) && (b != 0) && (c != 0)) {
                    x1 = -c/b
                    x2 = x1
                    if GetFraction(a: x1).count > 10 {
                        resultText = "x1 = \(-c) / \(b) \n x2 = \(-c) / \(b)"
                    } else {
                        resultText = "x1 = \(x1) \n x2 = \(x2)"
                    }
                    break
                }
                
                if ((a == 0) && (b != 0) && (c == 0)) {
                    x1 = 0
                    x2 = x1
                    resultText = "x1 = \(x1) \n x2 = \(x2)"
                    break
                }
                
                if ((a != 0) && (b != 0) && (c == 0)) {
                    x1 = 0
                    x2 = -b/a
                    if GetFraction(a: x2).count > 10 {
                        resultText = "x1 = \(x1) \n x2 = \(-b) / \(a)"
                    } else {
                        resultText = "x1 = \(x1) \n x2 = \(x2)"
                    }
                    break
                }
                
                if ((a != 0) && (b == 0) && (c != 0)) {
                    if (c/a > 0) {
                        resultText = "No solution"
                    } else {
                        x1 = _sqrt(number: -c/a)
                        x2 = -x1
                        if GetFraction(a: x1).count > 10 {
                            resultText = "x1 = √(\(-c) / \(a)) \n x2 = √(\(c) / \(a))"
                        } else {
                            resultText = "x1 = \(x1) \n x2 = \(x2)"
                        }
                    }
                    break
                }
                
                if ((a != 0) && (b == 0) && (c == 0)) {
                    x1 = 0
                    x2 = 0
                    resultText = "x1 = \(x1) \n x2 = \(x2)"
                    break
                }
                
                if ((a != 0) && ( b != 0) && (c != 0)) {
                    d = (b*b - 4*a*c)
                    for _ in 1...2 {
                        
                        if d<0 {
                            resultText = "Discriminant" + " < 0. \n" + "No solution"
                        }
                        
                        if d == 0 {
                            x1 = (-b/a2)
                            x2 = x1
                            x1Fraction = GetFraction(a: x1)
                            if x1Fraction.count <= 10 {
                                resultText = "Discriminant" + " = 0. \n x1 = x2 = \(x1)"
                            } else {
                                resultText = "Discriminant" + " = 0. \n x1 = x2 = \(-b) / \(a2)"
                            }
                        }
                        
                        if d>0 {
                            if (b.doubleValue.truncatingRemainder(dividingBy: 2)) != 0 {
                                
                                x1 = ((b.negativeValue + _sqrt(number: d)) / a2)
                                x2 = ((b.negativeValue - _sqrt(number: d)) / a2)
                                x1Fraction = GetFraction(a: x1)
                                x2Fraction = GetFraction(a: x2)
                                
                                switch x1Fraction.count {
                                case 6...:
                                    if GetFraction(a: _sqrt(number: d)).count > 10 {
                                        strx1 = "\(-b) + √\(d) / \(a2)"
                                    } else {
                                        strx1 = "\(b.negativeValue + _sqrt(number: d)) / \(a2)"
                                    }
                                case ...5:
                                    strx1 = "\(x1)"
                                default:
                                    return
                                }
                                
                                switch x2Fraction.count {
                                case 6...:
                                    if GetFraction(a: _sqrt(number: d)).count > 10 {
                                        strx2 = "\(-b) - √\(d) / \(a2)"
                                    } else {
                                        strx2 = "\(b.negativeValue - _sqrt(number: d)) / \(a2)"
                                    }
                                case ...5:
                                    strx2 = "\(x2)"
                                default:
                                    return
                                }
                                resultText = "Discriminant" + " = \(d) \n x1 = \(strx1) \n x2 = \(strx2)"
                                
                            } else {
                                b2 = b/2
                                d = (b2*b2 - a*c)
                                x1 = ((b2.negativeValue + _sqrt(number: d)) / a)
                                x2 = ((b2.negativeValue - _sqrt(number: d)) / a)
                                x1Fraction = GetFraction(a: x1)
                                x2Fraction = GetFraction(a: x2)
                                
                                switch x1Fraction.count {
                                case 6...:
                                    if GetFraction(a: _sqrt(number: d)).count > 10 {
                                        strx1 = "\(-b2) + √\(d) / \(a)"
                                    } else {
                                        strx1 = "\(b2.negativeValue + _sqrt(number: d)) / \(a)"
                                    }
                                case ...5:
                                    strx1 = "\(x1)"
                                default:
                                    return
                                }
                                
                                switch x2Fraction.count {
                                case 6...:
                                    if GetFraction(a: _sqrt(number: d)).count > 10 {
                                        strx2 = "\(-b2) - √\(d) / \(a)"
                                    } else {
                                        strx2 = "\(b2.negativeValue - _sqrt(number: d)) / \(a)"
                                    }
                                case ...5:
                                    strx2 = "\(x2)"
                                default:
                                    return
                                }
                                
                                resultText = "Discriminant" + "(1) = \(d) \n x1 = \(strx1) \n x2 = \(strx2)"
                            }
                        }
                    }
                    break
                }
            }
        }
    }
}
