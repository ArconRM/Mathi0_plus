//
//  LCM&GCD_View.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 15.02.2022.
//

import SwiftUI

struct LCM_GCD_View: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: LCM_GCD_ViewModel
    
    @State var showKeyboard: Bool = false
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.selectedTextField = .no
                    showKeyboard = false
                }
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
                    .padding(.top, 40)
                    .padding(.leading, 30)
                    .font(.system(size: UIScreen.screenHeight / 20))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()

                    Button("Clear") {
                        viewModel.Clear()
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                    .padding(.trailing, UIScreen.screenWidth / 3)
                    .padding(.top, 40)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                }
                
                Text(viewModel.aText)
                    .frame(height: UIScreen.screenHeight / 11)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.4) : Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .opacity(0.8)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.selectedTextField = .a
                            showKeyboard = true
                        }
                    }
                
                Text(viewModel.bText)
                    .frame(height: UIScreen.screenHeight / 11)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.4) : Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .opacity(0.8)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.selectedTextField = .b
                            showKeyboard = true
                        }
                    }
                
                Text(viewModel.cText)
                    .frame(height: UIScreen.screenHeight / 11)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.4) : Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .opacity(0.8)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.selectedTextField = .c
                            showKeyboard = true
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
                .padding(.vertical)
                .padding(.horizontal, 10)
                .font(.system(size: UIScreen.screenHeight / 27))
                .foregroundColor(.white)
                .background(.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.vertical)
                .opacity(0.8)
                
                Spacer()
                
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
                    showKeyboard = false
                }
            }
            LCM_GCD_KeyboardView(isShowing: $showKeyboard)
        }
    }
}

struct LCM_GCD_View_Previews: PreviewProvider {
    static var previews: some View {
        LCM_GCD_View(isPresented: .constant(true))
            .environmentObject(LCM_GCD_ViewModel())
    }
}
