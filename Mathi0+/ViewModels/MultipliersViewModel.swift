//
//  MultipliersViewModel.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 16.02.2022.
//

import Foundation
import SwiftUI

final class MultipliersViewModel: ObservableObject {
    
    @Published var numberText: String = "0"
    @Published var resultText: String = ""
    @Published var selectedTextField: textFields = .no
    
    func Solve() {
        if resultText != "" {
            resultText = ""
        }
        if numberText != "" {
            var a = Int(numberText)!
            var power: Int = 0
            var factor = 2
            
            while a > 1 {
                while a % factor == 0 {
                    a = a / factor
                    power += 1
                }
                if power != 0 {
                    resultText += "\(factor) ^ \(power)\n"
                }
                power = 0
                factor += 1
            }
        }
    }
    
    func Clear() {
        resultText = ""
        numberText = "0"
    }
}
