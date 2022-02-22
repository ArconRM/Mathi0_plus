//
//  SystemsViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 21.02.2022.
//

import Foundation
import SwiftUI

enum Systems: String, CaseIterable {
    case no = ""
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case eleven = "11"
    case twelve = "12"
    case thirteen = "13"
    case fourteen = "14"
    case fifteen = "15"
    case sixteen = "16"
}

enum Operations: String, CaseIterable {
    case no = ""
    case add = "Plus"
    case minus = "Minus"
}

final class SystemsViewModel: ObservableObject {
    
    @Published var aText: String = "0"
    @Published var bText: String = "0"
    @Published var resultText: String = ""
    
    @Published var selectedTextField: textFields = .no
    @Published var showKeyboard: Bool = false
    @Published var showChooseView: Bool = true
    @Published var showSystems: Bool = false
    @Published var showSystemsOperations: Bool = false
    
    @Published var system1: Systems = .no
    @Published var system2: Systems = .no
    @Published var operation: Operations = .no
    
    func checkSymbolsForSystem(a: String, system: Int) -> Bool {
        
        var number: Int = 0
        var notInSystem: Bool = true
        
        let symbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        for symbol in symbols {
            if a.contains(symbol) {
                number = alphabet16(a: symbol)
                if number >= system {
                    notInSystem = false
                    break
                }
            }
        }
        return notInSystem
    }
    
    func alphabet16(a: String) -> Int {
        var b:Int = 0
        switch a {
        case "A":
            b = 10
        case "B":
            b = 11
        case "C":
            b = 12
        case "D":
            b = 13
        case "E":
            b = 14
        case "F":
            b = 15
        default:
            b = Int(a)!
        }
        return b
    }
    
    func _pow(a: Int, k: Int) -> Int {
        var b: Int = 1
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
    
    func translate(a: String, kStart: Int, kEnd: Int) -> String {
        var was: Bool = false
        var b1: String = ""
        var b: Int = 0
        if (kStart == kEnd) {
            return a
        }
        if (kStart < 11) {
            b = Int(a)!
        }
        // переводим в 10
        var tLast: String = "" // последний символ в 16-ричной строке
        var x: Int = 0
        let i: Int = String(a).count
        
        switch kStart {
        case 2...9:
            x += b%10
            if i>1 {
                for k in 1...i-1 {
                    b = Int(String(b).dropLast(1))!
                    x += b%10 * _pow(a: kStart, k: k)
                }
            }
        case 10:
            x = Int(a)!
        case 11...16:
            b1 = a
            if (b1.last == "A") || (b1.last == "B") || (String(b1).last == "C") || (b1.last == "D") || (b1.last == "E") || (b1.last == "F") {
                tLast = String(b1.last!)
                x += alphabet16(a: tLast)
            } else {
                tLast = String(b1.last!)
                x += Int(tLast)! % 10
            }
            if i>1 {
                for k in 1...i-1 {
                    b1 = String(b1.dropLast(1))
                    if (b1.last == "A") || (b1.last == "B") || (b1.last == "C") || (b1.last == "D") || (b1.last == "E") || (b1.last == "F") {
                        tLast = String(b1.last!)
                        x += alphabet16(a: tLast) * _pow(a: kStart, k: k)
                    } else {
                        x += Int(String(b1.last!))! * _pow(a: kStart, k: k)
                    }
                }
            }
        default:
            return "Error"
        }
        // переводим из 10 в нужную
        
        var str: String = ""
        b = x
        
        switch kEnd {
        case 2...9:
            while !(b < kEnd) {
                str += String(b % kEnd)
                b = Int(b/kEnd)
            }
            str += String(b)
            str = String(str.reversed())
        case 10:
            str = String(b)
        case 11...16:
            if (b == 10) {
                str = "A"
                was = true
            } else if (b == 11) {
                str = "B"
                was = true
            } else if (b == 12) {
                str = "C"
                was = true
            } else if (b == 13) {
                str = "D"
                was = true
            } else if (b == 14) {
                str = "E"
                was = true
            } else if (b == 15) {
                str = "F"
                was = true
            }
            while !(b < kEnd) {
                if (b % kEnd < 10) {
                    str += String(b % kEnd)
                } else if (b % kEnd == 10) {
                    str += "A"
                } else if (b % kEnd == 11) {
                    str += "B"
                } else if (b % kEnd == 12) {
                    str += "C"
                } else if (b % kEnd == 13) {
                    str += "D"
                } else if (b % kEnd == 14) {
                    str += "E"
                } else if (b % kEnd == 15) {
                    str += "F"
                }
                b = Int(b/kEnd)
            }
            
            if String(b).count == 2 {
                if (b == 10) {
                    str += "A"
                } else if (b == 11) {
                    str += "B"
                } else if (b == 12) {
                    str += "C"
                } else if (b == 13) {
                    str += "D"
                } else if (b == 14) {
                    str += "E"
                } else if (b == 15) {
                    str += "F"
                }
            } else {
                str += String(b)
            }
            
            if (was == false) {
                str = String(str.reversed())
            }
        default:
            return "Error"
        }
        return str
    }
    
    func Clear() {
        resultText = ""
        aText = "0"
        bText = "0"
        selectedTextField = .no
        system1 = .no
        system2 = .no
        operation = .no
    }
    
    func SolveSystems() {
        resultText = ""
        if system1 != .no && system2 != .no && aText != "" {
            
            if checkSymbolsForSystem(a: aText, system: Int(system1.rawValue)!){
                
                if aText.first == "0" {
                    while aText.first == "0" {
                        aText = String(aText.dropFirst())
                    }
                }
                
                if system1 == system2 {
                    resultText = aText
                } else {
                    resultText = String(translate(a: String(aText), kStart: Int(system1.rawValue)!, kEnd: Int(system2.rawValue)!))
                }
            } else {
                resultText = "Error"
            }
        }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func SolveSystemsOpeations() {
        
        if (system1 != .no) && (operation != .no) && (aText != "") && (bText != "") {
            if checkSymbolsForSystem(a: aText, system: Int(system1.rawValue)!) && checkSymbolsForSystem(a: bText, system: Int(system1.rawValue)!) {
                if aText.first == "0" {
                    while aText.first == "0" {
                        aText = String(aText.dropFirst())
                    }
                }
                if bText.first == "0" {
                    while bText.first == "0" {
                        bText = String(bText.dropFirst())
                    }
                }
                
                let num1ForSum = String(translate(a: String(aText), kStart: Int(system1.rawValue)!, kEnd: 10))
                let num2ForSum = String(translate(a: String(bText), kStart: Int(system1.rawValue)!, kEnd: 10))
                var sum = 0
                
                if operation == .add {
                    sum = Int(num1ForSum)! + Int(num2ForSum)!
                } else if operation == .minus {
                    sum = Int(num1ForSum)! - Int(num2ForSum)!
                }
                
                resultText = String(translate(a: String(sum), kStart: 10, kEnd: Int(system1.rawValue)!))
                
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
            } else {
                resultText = "Error"
            }
        }
    }
}
