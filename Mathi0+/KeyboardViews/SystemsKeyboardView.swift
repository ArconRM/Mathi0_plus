//
//  SystemsKeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 21.02.2022.
//

import SwiftUI

struct SystemsKeyboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: SystemsViewModel
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
                                        default:
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
                                        default:
                                            return
                                        }
                                        
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.prepare()
                                        generator.impactOccurred()
                                    }
                                    .buttonStyle(SystemsKeyboardButtonStyle(item: item))
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
            withAnimation(.easeInOut) {
                isShowing = false
            }
        }
    }
}

public struct SystemsKeyboardButtonStyle: ButtonStyle {
    
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

struct SystemsKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        SystemsKeyboardView(isShowing: .constant(true))
            .environmentObject(SystemsViewModel())
    }
}
