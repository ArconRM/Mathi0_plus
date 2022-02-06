//
//  CalcFunctions.swift
//  Mathi0+ WatchKit Extension
//
//  Created by Artemiy Mirotvortsev on 06.02.2022.
//

import Foundation

func separatedNumber(strNumber: String, number: Decimal, wasCommaPressed: Bool) -> String {
    var formattedNumber: String = ""
    var integerPart: String = ""
    var fractionalPart: String = ""
    var i: Int = 0
    var place: Int = 0
    
    fractionalPart = GetFraction(a: strNumber)
    integerPart = String(number.whole)
    
    if integerPart.count > 3 {
        
        if integerPart.count % 3 == 0 {
            
            for number in integerPart {
                
                i += 1
                place += 1
                
                formattedNumber += String(number)
                
                if i == 3 {
                    if place != integerPart.count {
                        formattedNumber += " "
                        i = 0
                    }
                }
            }
            if wasCommaPressed == true {
                formattedNumber += "."
            }
        } else if integerPart.count % 3 == 1 {
            
            formattedNumber += String(integerPart.first!)
            integerPart = String(integerPart.dropFirst())
            formattedNumber += " "
            
            for number in integerPart {
                
                i += 1
                place += 1
                
                formattedNumber += String(number)
                
                if i == 3 {
                    if place != integerPart.count {
                        formattedNumber += " "
                        i = 0
                    }
                }
            }
            if wasCommaPressed == true {
                formattedNumber += "."
            }
        } else if integerPart.count % 3 == 2 {
            
            for _ in 1...2 {
                formattedNumber += String(integerPart.first!)
                integerPart = String(integerPart.dropFirst())
            }
            
            formattedNumber += " "
            
            for number in integerPart {
                
                i += 1
                place += 1
                
                formattedNumber += String(number)
                
                if i == 3 {
                    if place != integerPart.count {
                        formattedNumber += " "
                        i = 0
                    }
                }
            }
            if wasCommaPressed == true {
                formattedNumber += "."
            }
        }
    } else {
        formattedNumber = integerPart
        if wasCommaPressed {
            if formattedNumber.contains(".") == false {
                formattedNumber += "."
            }
        }
    }
    formattedNumber += fractionalPart
    return formattedNumber
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
