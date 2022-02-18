//
//  TrigonometryViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 17.02.2022.
//

import Foundation
import SwiftUI
import Darwin

final class TrigonometryViewModel: ObservableObject {
    
    var a: Int = 0
    
    @Published var numberText: String = "0"
    @Published var resultText: String = ""
    @Published var selectedTextField: textFields = .no
    
    func getTrygonometry(a: Int) -> String {
        var corner: Int = a
        var strSin: String = ""
        var strCos: String = ""
        var strTg: String = ""
        var strCtg: String = ""
        
        if corner < 0 {
            corner += 360
        }
        
        if (corner == 30) ||  (corner == 150) || (corner == 210) || (corner == 330){
            strSin = "1 / 2"
            strCos = "√3 / 2"
            strTg = "1 / √3"
            strCtg = "√3"
            
            switch corner {
            case 150:
                strCos = "- " + strCos
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            case 210:
                strSin = "- " + strSin
                strCos = "- " + strCos
            case 330:
                strSin = "- " + strSin
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            default:
                break
            }
        } else if (corner == 45) || (corner == 135) || (corner == 225) || (corner == 315) {
            strSin = "√2 / 2"
            strCos = "√2 / 2"
            strTg = "1"
            strCtg = "1"
            
            switch corner {
            case 135:
                strCos = "- " + strCos
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            case 225:
                strSin = "- " + strSin
                strCos = "- " + strCos
            case 315:
                strSin = "- " + strSin
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            default:
                break
            }
        } else if (corner == 60) || (corner == 120) || (corner == 240) || (corner == 300) {
            strSin = "√3 / 2"
            strCos = "1 / 2"
            strTg = "√3"
            strCtg = "1 / √3"
            switch corner {
            case 120:
                strCos = "- " + strCos
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            case 240:
                strSin = "- " + strSin
                strCos = "- " + strCos
            case 300:
                strSin = "- " + strSin
                strTg = "- " + strTg
                strCtg = "- " + strCtg
            default:
                break
            }
        } else if corner == 0 {
            strSin = "0"
            strCos = "1"
            strTg = "0"
            strCtg = "-"
        } else if corner == 90 {
            strSin = "1"
            strCos = "0"
            strTg = "-"
            strCtg = "0"
        } else if corner == 180 {
            strSin = "0"
            strCos = "-1"
            strTg = "0"
            strCtg = "-"
        } else if corner == 270 {
            strSin = "-1"
            strCos = "0"
            strTg = "-"
            strCtg = "0"
        } else {
            strSin = String(sin((Double.pi / 180) * Double(corner)).rounded(toPlaces: 5))
            strCos = String(cos((Double.pi / 180) * Double(corner)).rounded(toPlaces: 5))
            strTg = String(tan((Double.pi / 180) * Double(corner)).rounded(toPlaces: 5))
            strCtg = String((1 / tan((Double.pi / 180) * Double(corner))).rounded(toPlaces: 5))
        }
        
        return "\(corner)° \nSin = \(strSin) \nCos = \(strCos) \nTg = \(strTg) \nCtg = \(strCtg)"
    }
    
    func Solve() {
        if (numberText != "") && (numberText != "-") {
            a = Int(numberText)!
            
            if (a >= 360) && (a > 0) {
                while a >= 360 {
                    a -= 360
                }
                resultText = String(getTrygonometry(a: a))
            } else if (a < 360) && (a < 0) {
                while a < 0 {
                    a += 360
                }
                resultText = String(getTrygonometry(a: a))
            } else {
                resultText = String(getTrygonometry(a: a))
            }
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func Clear() {
        resultText = ""
        numberText = "0"
    }
    
}

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
