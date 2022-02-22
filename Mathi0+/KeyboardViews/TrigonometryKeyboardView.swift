//
//  TrigonometryKeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 17.02.2022.
//

import SwiftUI

struct TrigonometryKeyboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: TrigonometryViewModel
    @Binding var isShowing: Bool
    
    var buttons: [[keys]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.minus, .zero, .delete]
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
                                Button(item.rawValue) {
                                    switch viewModel.selectedTextField {
                                    case .a:
                                        if item == .delete {
                                            if viewModel.numberText != "" {
                                                viewModel.numberText = String(viewModel.numberText.dropLast())
                                                if viewModel.numberText == "" {
                                                    viewModel.numberText = "0"
                                                }
                                            }
                                        } else if item == .minus {
                                            if viewModel.numberText != "" {
                                                viewModel.numberText = "\(Decimal(string: viewModel.numberText)!.negativeValue)"
                                            }
                                        } else if item == .dot {
                                            if !viewModel.numberText.contains(".") {
                                                viewModel.numberText += item.rawValue
                                            }
                                        } else {
                                            if viewModel.numberText == "0" {
                                                viewModel.numberText = ""
                                            }
                                            viewModel.numberText += item.rawValue
                                        }
                                        
                                    default:
                                        return
                                    }
                                    
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.prepare()
                                    generator.impactOccurred()
                                }
                                .buttonStyle(TrigonometryKeyboardButtonStyle(item: item))
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

public struct TrigonometryKeyboardButtonStyle: ButtonStyle {
    
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
    }
}

struct TrigonometryKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        TrigonometryKeyboardView(isShowing: .constant(true))
            .environmentObject(TrigonometryViewModel())
    }
}
