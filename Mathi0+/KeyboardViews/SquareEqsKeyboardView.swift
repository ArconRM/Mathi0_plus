//
//  NumberCommaMinusKeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 13.02.2022.
//

import SwiftUI

enum keys: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case delete = "<-"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
    case zero = "0"
    case minus = "-"
}

struct SquareEqsKeyboardView: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: SquareEqsViewModel
    @Binding var isShowing: Bool
    
    var buttons: [[keys]] = [
        [.delete],
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.dot, .zero, .minus]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.gray.opacity(0)
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    ForEach(buttons, id: \.self) { row in
                        HStack{
                            ForEach(row, id: \.self) { item in
                                if item == .delete {
                                    Spacer()
                                    
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if viewModel.aText != "" {
                                                viewModel.aText = String(viewModel.aText.dropLast())
                                                if viewModel.aText == "" {
                                                    viewModel.aText = "0"
                                                }
                                            }
                                        case .b:
                                            if viewModel.bText != "" {
                                                viewModel.bText = String(viewModel.bText.dropLast())
                                                if viewModel.bText == "" {
                                                    viewModel.bText = "0"
                                                }
                                            }
                                        case .c:
                                            if viewModel.cText != "" {
                                                viewModel.cText = String(viewModel.cText.dropLast())
                                                if viewModel.cText == "" {
                                                    viewModel.cText = "0"
                                                }
                                            }
                                        case .no:
                                            return
                                        }
                                        
                                    }
                                    .padding(.trailing, 30)
                                    .buttonStyle(CalcKeyboardButtonStyle(item: item))
                                } else {
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if item == .minus {
                                                if viewModel.aText == "0" {
                                                    viewModel.aText = "-0"
                                                } else if viewModel.aText != ""{
                                                    viewModel.aText = "\(Decimal(string: viewModel.aText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.aText.contains(".") {
                                                    viewModel.aText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.aText == "0" {
                                                    viewModel.aText = ""
                                                } else if viewModel.aText == "-0" {
                                                    viewModel.aText = "-"
                                                }
                                                viewModel.aText += item.rawValue
                                            }
                                        case .b:
                                            if item == .minus {
                                                if viewModel.bText == "0" {
                                                    viewModel.bText = "-0"
                                                } else if viewModel.bText != ""{
                                                    viewModel.bText = "\(Decimal(string: viewModel.bText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.bText.contains(".") {
                                                    viewModel.bText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.bText == "0" {
                                                    viewModel.bText = ""
                                                } else if viewModel.bText == "-0" {
                                                    viewModel.bText = "-"
                                                }
                                                viewModel.bText += item.rawValue
                                            }
                                        case .c:
                                            if item == .minus {
                                                if viewModel.cText == "0" {
                                                    viewModel.cText = "-0"
                                                } else if viewModel.cText != ""{
                                                    viewModel.cText = "\(Decimal(string: viewModel.cText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.cText.contains(".") {
                                                    viewModel.cText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.cText == "0" {
                                                    viewModel.cText = ""
                                                } else if viewModel.cText == "-0" {
                                                    viewModel.cText = "-"
                                                }
                                                viewModel.cText += item.rawValue
                                            }
                                        case .no:
                                            return
                                        }
                                        
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.prepare()
                                        generator.impactOccurred()
                                    }
                                    .buttonStyle(CalcKeyboardButtonStyle(item: item))
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .padding(.bottom, 20)
                .background(colorScheme == .dark ? Color.gray.brightness(0.1) : Color.gray.brightness(0.3))
                .cornerRadius(20)
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            isShowing = false
        }
        .animation(.easeInOut)
    }
}

public struct CalcKeyboardButtonStyle: ButtonStyle {
    
    var item: keys
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: item == .delete ? 60 : 100)
            .frame(height: item == .delete ? 40 : 45)
            .background(configuration.isPressed ? .white : .white.opacity(0.7))
            .cornerRadius(5)
            .foregroundColor(.black)
            .font(.system(size: 25))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
    }
}


struct SquareEqsKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        SquareEqsKeyboardView(isShowing: .constant(true))
    }
}
