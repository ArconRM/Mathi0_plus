//
//  MultipliersView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 16.02.2022.
//

import SwiftUI

struct MultipliersView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: MultipliersViewModel
    
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
                
                Text(viewModel.numberText)
                    .frame(width: UIScreen.screenWidth - 30)
                    .frame(height: UIScreen.screenHeight / 10)
                    .foregroundColor(.black)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                    .cornerRadius(5)
                    .opacity(0.8)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.selectedTextField = .a
                            showKeyboard = true
                        }
                    }
                
                Button("Decompose") {
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
                
                Spacer()
                
                Text(viewModel.resultText)
                    .font(.system(size: UIScreen.screenHeight / 32))
                    .frame(width: UIScreen.screenWidth - 30)
                    .frame(height: UIScreen.screenHeight / 2)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showKeyboard = true
                }
            }
            MultipliersKeyboardView(isShowing: $showKeyboard)
                .environmentObject(viewModel)
        }
        
    }
}


struct MultipliersView_Previews: PreviewProvider {
    static var previews: some View {
        MultipliersView(isPresented: .constant(true))
            .environmentObject(MultipliersViewModel())
    }
}
