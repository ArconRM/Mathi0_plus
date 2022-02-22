//
//  ConverterKeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 19.02.2022.
//

import SwiftUI

struct ConverterKeyboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ConverterViewModel
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
                    .onTapGesture {
                        viewModel.selectedTextField = .no
                        isShowing = false
                    }
                
                VStack(spacing: 15) {
                    ForEach(buttons, id: \.self) { row in
                        HStack{
                            ForEach(row, id: \.self) { item in
                                if item == .delete {
                                    Spacer()
                                    
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if viewModel.number1Text != "" {
                                                viewModel.number1Text = String(viewModel.number1Text.dropLast())
                                                if viewModel.number1Text == "" {
                                                    viewModel.number1Text = "0"
                                                }
                                            }
                                        default:
                                            return
                                        }
                                    }
                                    .padding(.trailing, 30)
                                    .buttonStyle(ConverterKeyboardButtonStyle(item: item))
                                } else {
                                    Button(item.rawValue) {
                                        switch viewModel.selectedTextField {
                                        case .a:
                                            if item == .minus {
                                                if viewModel.number1Text == "0" {
                                                    viewModel.number1Text = "-0"
                                                } else if viewModel.number1Text != ""{
                                                    viewModel.number1Text = "\(Decimal(string: viewModel.number1Text)!.negativeValue)"
                                                }
                                            } else if item == .dot {
                                                if !viewModel.number1Text.contains(".") {
                                                    viewModel.number1Text += item.rawValue
                                                }
                                            } else {
                                                if viewModel.number1Text == "0" {
                                                    viewModel.number1Text = ""
                                                } else if viewModel.number1Text == "-0" {
                                                    viewModel.number1Text = "-"
                                                }
                                                viewModel.number1Text += item.rawValue
                                            }
                                        default:
                                            return
                                        }
                                        
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.prepare()
                                        generator.impactOccurred()
                                    }
                                    .buttonStyle(ConverterKeyboardButtonStyle(item: item))
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

public struct ConverterKeyboardButtonStyle: ButtonStyle {
    
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

struct ConverterKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterKeyboardView(isShowing: .constant(true))
            .environmentObject(ConverterViewModel())
    }
}
