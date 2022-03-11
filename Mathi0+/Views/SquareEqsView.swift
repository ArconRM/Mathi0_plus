//
//  SquareEqsView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 13.02.2022.
//

import SwiftUI

struct SquareEqsView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: SquareEqsViewModel
    
    @State var showKeyboard: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button("<") {
                        withAnimation(.easeInOut) {
                            isPresented = false
                        }
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                    .padding(.leading, 30)
                    .font(.system(size: UIScreen.screenHeight / 20))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()
                    
                    Button("Clear") {
                        viewModel.Clear()
                        showKeyboard = false
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                    .padding(.trailing, UIScreen.screenWidth / 3)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                }
                .padding(.top, 40)
                
                HStack {
                    Text("a =")
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .padding(.vertical, UIScreen.screenHeight / 55)
                    
                    Text(viewModel.aText)
                        .frame(width: UIScreen.screenWidth - 115)
                        .frame(height: UIScreen.screenHeight / 13)
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .a
                                showKeyboard = true
                            }
                        }
                }
                HStack {
                    Text("b =")
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .padding(.vertical, UIScreen.screenHeight / 55)
                    
                    Text(viewModel.bText)
                        .frame(width: UIScreen.screenWidth - 115)
                        .frame(height: UIScreen.screenHeight / 13)
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .b ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .b
                                showKeyboard = true
                            }
                        }
                }
                
                HStack {
                    Text("c =")
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .padding(.vertical, UIScreen.screenHeight / 55)
                    
                    Text(viewModel.cText)
                        .frame(width: UIScreen.screenWidth - 115)
                        .frame(height: UIScreen.screenHeight / 13)
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .c ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .c
                                showKeyboard = true
                            }
                        }
                }
                
                Button("Solve") {
                    viewModel.Solve()
                    showKeyboard = false
                    viewModel.selectedTextField = .no
                    
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
                .frame(width: UIScreen.screenWidth - 60)
                .padding()
                .font(.system(size: UIScreen.screenHeight / 27))
                .foregroundColor(.white)
                .background(.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.vertical)
                .opacity(0.8)
                
                Text(viewModel.resultText)
                    .font(.system(size: UIScreen.screenHeight / 32))
                    .frame(width: UIScreen.screenWidth - 30)
                    .frame(height: UIScreen.screenHeight / 3 + 20)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Spacer()
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showKeyboard = true
                }
            }
            SquareEqsKeyboardView(isShowing: $showKeyboard)
        }
    }
}

struct SquareEqsView_Previews: PreviewProvider {
    static var previews: some View {
        SquareEqsView(isPresented: .constant(true))
            .environmentObject(SquareEqsViewModel())
.previewInterfaceOrientation(.portrait)
    }
}
