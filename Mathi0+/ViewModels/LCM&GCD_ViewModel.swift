//
//  LCM&GCD_ViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 15.02.2022.
//

import Foundation
import SwiftUI

final class LCM_GCD_ViewModel: ObservableObject {
    
    @Published var aText: String = "0"
    @Published var bText: String = "0"
    @Published var cText: String = "0"
    @Published var resultText: String = ""
    
    @Published var selectedTextField: textFields = .no
    
    func Clear() {
        aText = "0"
        bText = "0"
        cText = "0"
    }
    
    func Solve() {
        
        var x = 0
        var x1 = 0
        var a: Int
        var b: Int
        var c: Int
        var flag = false
        if (aText != "0") && (bText != "0") && (cText != "0") {
            // НОК
            a = Int(aText)!
            b = Int(bText)!
            c = Int(cText)!
            while flag == false {
                x += 1
                if ((x % a == 0) && (x % b == 0) && (x % c == 0)) {
                    flag = true
                }
            }
            flag = false
            
            // НОД
            var x1 = 1
            if (((a>b) || (a == b)) && ((a>c) || (a == c))) { x1 = a }
            if (((b>a) || (b == a)) && ((b>c) || (b == c))) { x1 = b }
            if (((c>a) || (c == a)) && ((c>b) || (c == b))) { x1 = c }
            while flag == false {
                x1 -= 1
                if ((a % x1 == 0) && (b % x1 == 0) && (c % x1 == 0)) {
                    flag = true
                }
            }
            resultText = "\("LCM") = \(x) \n\("GCD") = \(x1)"
        }
        
        if (aText != "0") && (bText != "0") && (cText == "0") {
            // НОК
            a = Int(aText)!
            b = Int(bText)!
            while flag == false {
                x += 1
                if ((x % a == 0) && (x % b == 0)) {
                    flag = true
                }
            }
            flag = false
            
            // НОД
            if ((a>b) || (a == b)) { x1 = a }
            if ((b>a) || (b == a)) { x1 = b }
            while flag == false {
                x1 -= 1
                if ((a % x1 == 0) && (b % x1 == 0)) {
                    flag = true
                }
            }
            resultText = "\("LCM") = \(x) \n\("GCD") = \(x1)"
        }
    }
}
