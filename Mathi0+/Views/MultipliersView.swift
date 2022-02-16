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
                    .font(.system(size: 40))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()
                    
                    Button("Clear") {
                        viewModel.Clear()
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                    .padding(.trailing, UIScreen.screenWidth / 2.5)
                    .padding(.top, 40)
                    .font(.system(size: 30))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                }
                
                Text(viewModel.numberText)
                    .frame(height: 70)
                    .foregroundColor(.black)
                    .frame(width: 340.0)
                    .font(.system(size: 30))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                    .cornerRadius(5)
                    .opacity(0.8)
                    .onTapGesture {
                        viewModel.selectedTextField = .a
                        showKeyboard = true
                    }
                    .animation(.easeInOut)
                
                Button("Decompose") {
                    viewModel.Solve()
                    showKeyboard = false
                    viewModel.selectedTextField = .no

                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
                .padding(.horizontal, 80)
                .padding()
                .font(.system(size: 30))
                .foregroundColor(.white)
                .background(.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.vertical)
                .opacity(0.8)
                
                Spacer()
                
                Text(viewModel.resultText)
                    .font(.system(size: 25))
                    .frame(width: UIScreen.screenWidth - 30)
                    .frame(height: UIScreen.screenHeight / 3 + 90)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
            }
            
            .onTapGesture {
                showKeyboard = false
            }
            .animation(.easeInOut)
            MultipliersKeyboardView(isShowing: $showKeyboard)
        }
    }
}


struct MultipliersView_Previews: PreviewProvider {
    static var previews: some View {
        MultipliersView(isPresented: .constant(true))
            .environmentObject(MultipliersViewModel())
    }
}
