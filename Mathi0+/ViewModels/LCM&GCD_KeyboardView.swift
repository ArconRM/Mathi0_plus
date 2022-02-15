//
//  LCM&GCD_KeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 15.02.2022.
//

import SwiftUI

struct LCM_GCD_KeyboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: LCM_GCD_ViewModel
    @Binding var isShowing: Bool
    
    var buttons: [[keys]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.zero, .delete]
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
                                if item == .zero {
                                    Spacer()
                                    
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if viewModel.aText == "0" {
                                                viewModel.aText = ""
                                            }
                                            viewModel.aText += item.rawValue
                                        case .b:
                                            if viewModel.bText == "0" {
                                                viewModel.bText = ""
                                            }
                                            viewModel.bText += item.rawValue
                                        case .c:
                                            if viewModel.cText == "0" {
                                                viewModel.cText = ""
                                            }
                                            viewModel.cText += item.rawValue
                                        default:
                                            return
                                        }
                                    }
                                    .buttonStyle(LCM_GCD_KeyboardButtonStyle(item: item))
                                } else {
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if item == .delete {
                                                if viewModel.aText != "" {
                                                    viewModel.aText = String(viewModel.aText.dropLast())
                                                    if viewModel.aText == "" {
                                                        viewModel.aText = "0"
                                                    }
                                                }
                                            } else if item == .minus {
                                                if viewModel.aText != "" {
                                                    viewModel.aText = "\(Decimal(string: viewModel.aText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.aText.contains(".") {
                                                    viewModel.aText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.aText == "0" {
                                                    viewModel.aText = ""
                                                }
                                                viewModel.aText += item.rawValue
                                            }
                                        case .b:
                                            if item == .delete {
                                                if viewModel.bText != "" {
                                                    viewModel.bText = String(viewModel.bText.dropLast())
                                                    if viewModel.bText == "" {
                                                        viewModel.bText = "0"
                                                    }
                                                }
                                            } else if item == .minus {
                                                if viewModel.bText != "" {
                                                    viewModel.bText = "\(Decimal(string: viewModel.bText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.bText.contains(".") {
                                                    viewModel.bText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.bText == "0" {
                                                    viewModel.bText = ""
                                                }
                                                viewModel.bText += item.rawValue
                                            }
                                        case .c:
                                            if item == .delete {
                                                if viewModel.cText != "" {
                                                    viewModel.cText = String(viewModel.cText.dropLast())
                                                    if viewModel.cText == "" {
                                                        viewModel.cText = "0"
                                                    }
                                                }
                                            } else if item == .minus {
                                                if viewModel.cText != "" {
                                                    viewModel.cText = "\(Decimal(string: viewModel.cText)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.cText.contains(".") {
                                                    viewModel.cText += item.rawValue
                                                }
                                            } else {
                                                if viewModel.cText == "0" {
                                                    viewModel.cText = ""
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
                                    .buttonStyle(LCM_GCD_KeyboardButtonStyle(item: item))
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

public struct LCM_GCD_KeyboardButtonStyle: ButtonStyle {
    
    var item: keys
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 100)
            .frame(height: 45)
            .background(configuration.isPressed ? .white : .white.opacity(0.7))
            .cornerRadius(5)
            .foregroundColor(.black)
            .font(.system(size: 25))
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .padding(.trailing, item == .delete ? 30 : 0)
    }
}

struct LCM_GCD_KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        LCM_GCD_KeyboardView(isShowing: .constant(true))
            .environmentObject(LCM_GCD_ViewModel())
    }
}
