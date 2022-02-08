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
    case comma = ","
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
    
    @EnvironmentObject var viewModel: CalcViewModel
    
    let buttons: [[CalcButtons]] = [
        [.clear, .sqrt, .square, .cube],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .comma, .equal],
        [.factorial, .negative, .percent, .divide]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(viewModel.resultText)
                    .font(.system(size: 25))
            }
            ScrollView {
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.solve(item: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 15))
                            }
                            .buttonStyle(CalcButtonStyle(text: item))
                        }
                    }
                }
            }
        }
    }
}

struct CalcButtonStyle: ButtonStyle {
    
    var text: CalcButtons
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 15, height: 15, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? .gray.opacity(0.6) : .gray.opacity(0.3))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}

struct CalcView_Previews: PreviewProvider {
    static var previews: some View {
        CalcView()
    }
}
