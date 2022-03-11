//
//  PifagorKeyboardView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 19.02.2022.
//

import SwiftUI

struct PifagorKeyboardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: PifagorViewModel
    @Binding var isShowing: Bool
    
    var buttons: [[keys]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.sqrt, .zero, .delete]
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
                                            if viewModel.aText != "" {
                                                viewModel.aText = String(viewModel.aText.dropLast())
                                                if viewModel.aText == "" {
                                                    viewModel.aText = "0"
                                                } else if viewModel.aText == "√" {
                                                    viewModel.aText = "√0"
                                                }
                                            }
                                        } else if item == .sqrt {
                                            if viewModel.aText != "" {
                                                if !viewModel.aText.contains("√") {
                                                    viewModel.aText = "√" + viewModel.aText
                                                } else {
                                                    viewModel.aText = String(viewModel.aText.dropFirst())
                                                }
                                            }
                                        } else if item == .dot {
                                            if !viewModel.aText.contains(".") {
                                                viewModel.aText += item.rawValue
                                            }
                                        } else {
                                            if viewModel.aText == "0" {
                                                viewModel.aText = ""
                                            } else if viewModel.aText == "√0" {
                                                viewModel.aText = "√"
                                            }
                                            viewModel.aText += item.rawValue
                                        }
                                        
                                    case .b:
                                        if item == .delete {
                                            if viewModel.bText != "" {
                                                viewModel.bText = String(viewModel.bText.dropLast())
                                                if viewModel.bText == "" {
                                                    viewModel.bText = "0"
                                                } else if viewModel.bText == "√" {
                                                    viewModel.bText = "√0"
                                                }
                                            }
                                        } else if item == .sqrt {
                                            if viewModel.bText != "" {
                                                if !viewModel.bText.contains("√") {
                                                    viewModel.bText = "√" + viewModel.bText
                                                } else {
                                                    viewModel.bText = String(viewModel.bText.dropFirst())
                                                }
                                            }
                                        } else if item == .dot {
                                            if !viewModel.bText.contains(".") {
                                                viewModel.bText += item.rawValue
                                            }
                                        } else {
                                            if viewModel.bText == "0" {
                                                viewModel.bText = ""
                                            } else if viewModel.bText == "√0" {
                                                viewModel.bText = "√"
                                            }
                                            viewModel.bText += item.rawValue
                                        }
                                        
                                    case .c:
                                        if item == .delete {
                                            if viewModel.cText != "" {
                                                viewModel.cText = String(viewModel.cText.dropLast())
                                                if viewModel.cText == "" {
                                                    viewModel.cText = "0"
                                                } else if viewModel.cText == "√" {
                                                    viewModel.cText = "√0"
                                                }
                                            }
                                        } else if item == .sqrt {
                                            if viewModel.cText != "" {
                                                if !viewModel.cText.contains("√") {
                                                    viewModel.cText = "√" + viewModel.cText
                                                } else {
                                                    viewModel.cText = String(viewModel.cText.dropFirst())
                                                }
                                            }
                                        } else if item == .dot {
                                            if !viewModel.cText.contains(".") {
                                                viewModel.cText += item.rawValue
                                            }
                                        } else {
                                            if viewModel.cText == "0" {
                                                viewModel.cText = ""
                                            } else if viewModel.cText == "√0" {
                                                viewModel.cText = "√"
                                            }
                                            viewModel.cText += item.rawValue
                                        }
                                        
                                    default:
                                        return
                                    }
                                    
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.prepare()
                                    generator.impactOccurred()
                                }
                                .buttonStyle(PifagorKeyboardButtonStyle(item: item))
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

public struct PifagorKeyboardButtonStyle: ButtonStyle {
    
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

struct PifagorKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        PifagorKeyboardView(isShowing: .constant(true))
            .environmentObject(PifagorViewModel())
    }
}
