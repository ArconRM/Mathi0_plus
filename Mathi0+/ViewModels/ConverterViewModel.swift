//
//  ConverterViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 17.02.2022.
//

import Foundation
import SwiftUI

enum lengthValues: String, CaseIterable {
    case no = ""
    case mm = "mm"
    case cm = "cm"
    case m = "m"
    case km = "km"
}

enum squareValues: String, CaseIterable  {
    case no = ""
    case mm = "mm^2"
    case cm = "cm^2"
    case m = "m^2"
    case km = "km^2"
}

enum volumeValues: String, CaseIterable  {
    case no = ""
    case mm = "mm^3"
    case cm = "cm^3"
    case m = "m^3"
    case km = "km^3"
}

enum massValues: String, CaseIterable  {
    case no = ""
    case mg = "mg"
    case g = "g"
    case kg = "kg"
    case ton = "ton"
}

enum temperatureValues: String, CaseIterable  {
    case no = ""
    case c = "°C"
    case k = "K"
    case f = "°F"
}

enum timeValues: String, CaseIterable  {
    case no = ""
    case msec = "msec"
    case sec = "sec"
    case min = "min"
    case hour = "hour"
}

enum typesOfValues: String, CaseIterable  {
    case no = ""
    case length = "Length"
    case square = "Square"
    case volume = "Volume"
    case mass = "Mass"
    case temp = "Temperature"
    case time = "Time"
}

enum typesOfValuesInt: Int {
    case no = 0
    case length = 1
    case square = 2
    case volume = 3
    case mass = 4
    case temp = 5
    case time = 6
}









final class ConverterViewModel: ObservableObject {
    
    @Published var number1Text: String = "0"
    @Published var number2Text: String = "0"
    @Published var resultText: String = ""
    @Published var value1: String = ""
    @Published var value2: String = ""
    @Published var selectedTextField: textFields = .no
    
    var a: Decimal = 0.0
    var b: Decimal = 0.0
    var currentTag: Int = 0
    
    @Published var valuesType: typesOfValues = .no
    
    func defineValues() -> [String] {
        var arr: [String] = []
        switch valuesType {
        case .no:
            return [""]
        case .length:
            for unit in lengthValues.allCases {
                arr.append(unit.rawValue)
            }
        case .square:
            for unit in squareValues.allCases {
                arr.append(unit.rawValue)
            }
        case .volume:
            for unit in volumeValues.allCases {
                arr.append(unit.rawValue)
            }
        case .mass:
            for unit in massValues.allCases {
                arr.append(unit.rawValue)
            }
        case .temp:
            for unit in temperatureValues.allCases {
                arr.append(unit.rawValue)
            }
        case .time:
            for unit in timeValues.allCases {
                arr.append(unit.rawValue)
            }
        }
        return arr
    }
    
    func Number1Changed() {
        if (number1Text != "") {
            a = Decimal(string: number1Text)!
        } else {
            a = 0.0
        }
        number2Text = translate()
    }
    
    func Value1Changed() {
        if (number1Text != "") {
            a = Decimal(string: number1Text)!
        } else {
            a = 0.0
        }
        number2Text = translate()
    }
    
    func Value2Changed() {
        if (number1Text != "") {
            a = Decimal(string: number1Text)!
        } else {
            a = 0.0
        }
        number2Text = translate()
    }
    
    func Swap() {
        var value: String
        value = value1
        value1 = value2
        value2 = value
        Value1Changed()
    }
    
    func Clear() {
        number1Text = "0"
        number2Text = "0"
        value1 = ""
        value2 = ""
        valuesType = .no
    }
    
    func translate() -> String {
        switch valuesType {
        case .length:
            switch value1 {
            case "mm":
                if value2 == "mm" {
                    resultText = "\(a)"
                }
                if value2 == "cm" {
                    resultText = "\(a/10)"
                }
                if value2 == "m" {
                    resultText = "\(a/1000)"
                }
                if value2 == "km" {
                    resultText = "\(a/1000000)"
                }
                
            case "cm":
                if value2 == "mm" {
                    resultText = "\(a*10)"
                }
                if value2 == "cm" {
                    resultText = "\(a)"
                }
                if value2 == "m" {
                    resultText = "\(a/100)"
                }
                if value2 == "km" {
                    resultText = "\(a/100000)"
                }
            case "m":
                if value2 == "mm" {
                    resultText = "\(a*1000)"
                }
                if value2 == "cm" {
                    resultText = "\(a*100)"
                }
                if value2 == "m" {
                    resultText = "\(a)"
                }
                if value2 == "km" {
                    resultText = "\(a/1000)"
                }
                
            case "km":
                if value2 == "mm" {
                    resultText = "\(a*1000000)"
                }
                if value2 == "cm" {
                    resultText = "\(a*100000)"
                }
                if value2 == "m" {
                    resultText = "\(a*1000)"
                }
                if value2 == "km" {
                    resultText = "\(a)"
                }
                
            default:
                return "Error"
            }
        case .square:
            switch value1 {
            case "mm^2":
                if value2 == "mm^2" {
                    resultText = "\(a)"
                }
                if value2 == "cm^2" {
                    resultText = "\(a/100)"
                }
                if value2 == "m^2" {
                    resultText = "\(a/1000000)"
                }
                if value2 == "km^2" {
                    resultText = "\(a/1000000000000)"
                }
                
            case "cm^2":
                if value2 == "mm^2" {
                    resultText = "\(a*100)"
                }
                if value2 == "cm^2" {
                    resultText = "\(a)"
                }
                if value2 == "m^2" {
                    resultText = "\(a/10000)"
                }
                if value2 == "km^2" {
                    resultText = "\(a/10000000000)"
                }
            case "m^2":
                if value2 == "mm^2" {
                    resultText = "\(a*1000000)"
                }
                if value2 == "cm^2" {
                    resultText = "\(a*10000)"
                }
                if value2 == "m^2" {
                    resultText = "\(a)"
                }
                if value2 == "km^2" {
                    resultText = "\(a/1000000)"
                }
                
            case "km^2":
                if value2 == "mm^2" {
                    resultText = "\(a*1000000000000)"
                }
                if value2 == "cm^2" {
                    resultText = "\(a*10000000000)"
                }
                if value2 == "m^2" {
                    resultText = "\(a*1000000)"
                }
                if value2 == "km^2" {
                    resultText = "\(a)"
                }
                
            default:
                return "Error"
            }
        case .volume:
            switch value1 {
            case "mm^3":
                if value2 == "mm^3" {
                    resultText = "\(a)"
                }
                if value2 == "cm^3" {
                    resultText = "\(a/1000)"
                }
                if value2 == "m^3" {
                    resultText = "\(a/1000000000)"
                }
                if value2 == "km^3" {
                    resultText = "\(a/1000000000000000000)"
                }
                
            case "cm^3":
                if value2 == "mm^3" {
                    resultText = "\(a*1000)"
                }
                if value2 == "cm^3" {
                    resultText = "\(a)"
                }
                if value2 == "m^3" {
                    resultText = "\(a/1000000)"
                }
                if value2 == "km^3" {
                    resultText = "\(a/1000000000000000)"
                }
            case "m^3":
                if value2 == "mm^3" {
                    resultText = "\(a*1000000000)"
                }
                if value2 == "cm^3" {
                    resultText = "\(a*1000000)"
                }
                if value2 == "m^3" {
                    resultText = "\(a)"
                }
                if value2 == "km^3" {
                    resultText = "\(a/1000000000)"
                }
                
            case "km^3":
                if value2 == "mm^3" {
                    resultText = "\(a*1000000000000000000)"
                }
                if value2 == "cm^3" {
                    resultText = "\(a*1000000000000000)"
                }
                if value2 == "m^3" {
                    resultText = "\(a*1000000000)"
                }
                if value2 == "km^3" {
                    resultText = "\(a)"
                }
                
            default:
                return "Error"
            }
        case .mass:
            switch value1 {
            case "mg":
                if value2 == "mg" {
                    resultText = "\(a)"
                }
                if value2 == "g" {
                    resultText = "\(a/1000)"
                }
                if value2 == "kg" {
                    resultText = "\(a/1000000)"
                }
                if value2 == "ton" {
                    resultText = "\(a/1000000000)"
                }
                
            case "g":
                if value2 == "mg" {
                    resultText = "\(a*1000)"
                }
                if value2 == "g" {
                    resultText = "\(a)"
                }
                if value2 == "kg" {
                    resultText = "\(a/1000)"
                }
                if value2 == "ton" {
                    resultText = "\(a/1000000)"
                }
            case "kg":
                if value2 == "mg" {
                    resultText = "\(a*1000000)"
                }
                if value2 == "g" {
                    resultText = "\(a*1000)"
                }
                if value2 == "kg" {
                    resultText = "\(a)"
                }
                if value2 == "ton" {
                    resultText = "\(a/1000)"
                }
                
            case "ton":
                if value2 == "mg" {
                    resultText = "\(a*1000000000)"
                }
                if value2 == "g" {
                    resultText = "\(a*100000000)"
                }
                if value2 == "kg" {
                    resultText = "\(a*10000)"
                }
                if value2 == "ton" {
                    resultText = "\(a)"
                }
                
            default:
                return "Error"
            }
        case .temp:
            switch value1 {
            case "°C":
                if value2 == "°C" {
                    resultText = "\(a)"
                }
                if value2 == "K" {
                    resultText = "\(a + 273)"
                }
                if value2 == "°F" {
                    resultText = "\(1.8*a + 32.8)"
                }
            case "K":
                if value2 == "°C" {
                    resultText = "\(a - 273)"
                }
                if value2 == "K" {
                    resultText = "\(a)"
                }
                if value2 == "°F" {
                    resultText = "\(1.8 * (a - 273) + 32)"
                }
            case "°F":
                if value2 == "°C" {
                    resultText = "\((a - 32) / 1.8)"
                }
                if value2 == "K" {
                    resultText = "\((a + 459.67) / 5/9)"
                }
                if value2 == "°F" {
                    resultText = "\(a)"
                }
            default:
                return "Error"
            }
        case .time:
            switch value1 {
            case "msec":
                if value2 == "msec" {
                    resultText = "\(a)"
                }
                if value2 == "sec" {
                    resultText = "\(a/1000)"
                }
                if value2 == "min" {
                    resultText = "\(a/60000)"
                }
                if value2 == "hour" {
                    resultText = "\(a/3600000)"
                }
                
            case "sec":
                if value2 == "msec" {
                    resultText = "\(a*1000)"
                }
                if value2 == "sec" {
                    resultText = "\(a)"
                }
                if value2 == "min" {
                    resultText = "\(a/60)"
                }
                if value2 == "hour" {
                    resultText = "\(a/3600)"
                }
            case "min":
                if value2 == "msec" {
                    resultText = "\(a*60000)"
                }
                if value2 == "sec" {
                    resultText = "\(a*60)"
                }
                if value2 == "min" {
                    resultText = "\(a)"
                }
                if value2 == "hour" {
                    resultText = "\(a/60)"
                }
                
            case "hour":
                if value2 == "msec" {
                    resultText = "\(a*3600000)"
                }
                if value2 == "sec" {
                    resultText = "\(a*3600)"
                }
                if value2 == "min" {
                    resultText = "\(a*60)"
                }
                if value2 == "hour" {
                    resultText = "\(a)"
                }
                
            default:
                return "Error"
            }
        default:
            return "Error"
        }
        
        return resultText
    }
}
