//
//  ContentView.swift
//  Mathi0+ WatchKit Extension
//
//  Created by Artemiy Mirotvortsev on 06.02.2022.
//

import SwiftUI

enum CalcButtons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case dot = "."
    case equal = "="
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case clear = "C"
    case percent = "%"
    case negative = "+-"
    case sqrt = "√"
    case square = "^2"
    case cube = "^3"
    case factorial = "x!"
}


struct CalcView: View {
    
    let buttons: [[CalcButtons]] = [
            [.clear, .sqrt, .square, .cube],
            [.seven, .eight, .nine, .multiply],
            [.four, .five, .six, .subtract],
            [.one, .two, .three, .add],
            [.zero, .dot, .equal],
            [.factorial, .negative, .percent, .divide]
        ]
        @State var resultText: String = "0"
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text(resultText)
                        .font(.system(size: 25))
                }
                ScrollView {
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { item in
                                Button {
                                    switch item {
                                    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
                                        if (resultText.count < 18){
                                            if resultText == "0" {
                                                resultText = ""
                                            }
                                            if resultText == "-0" {
                                                resultText = String(resultText.dropLast())
                                            }
                                            resultText += item.rawValue
                                        }
                                    case .clear:
                                        resultText = "0"
                                    case .sqrt:
                                        resultText = "\(_sqrt(number: (Decimal(string: resultText) ?? 0)))"
                                    case .square:
                                        resultText = _pow(a: (Decimal(string: resultText) ?? 0), k: 2)
                                    case .cube:
                                        resultText = _pow(a: (Decimal(string: resultText) ?? 0), k: 3)
                                    case .dot:
                                        resultText += "."
                                    default:
                                        resultText = "error"
                                    }
                                } label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 15))
                                }
                                .buttonStyle(CalcButtonStyle())
                            }
                        }
                    }
                }
            }
        }
    }

    struct CalcButtonStyle: ButtonStyle {
     
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(width: 15, height: 15, alignment: .center)
                .padding()
                .foregroundColor(.white)
                .background(.gray.opacity(0.3))
                .cornerRadius(40)
        }
    }

struct CalcView_Previews: PreviewProvider {
    static var previews: some View {
        CalcView()
    }
}
