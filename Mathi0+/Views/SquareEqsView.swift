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
                
                HStack {
                    Text("a =")
                        .font(.system(size: 40))
                        .padding()
                    
                    Text(viewModel.aText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 260.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.trailing, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            viewModel.selectedTextField = .a
                            showKeyboard = true
                        }
                        .animation(.easeInOut)
                }
                HStack {
                    Text("b =")
                        .font(.system(size: 40))
                        .padding()
                    
                    Text(viewModel.bText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 260.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .b ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.trailing, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            viewModel.selectedTextField = .b
                            showKeyboard = true
                        }
                        .animation(.easeInOut)
                }
                HStack {
                    Text("c =")
                        .font(.system(size: 40))
                        .padding()
                    
                    Text(viewModel.cText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 260.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .c ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .padding(.trailing, 10)
                        .opacity(0.8)
                        .onTapGesture {
                            viewModel.selectedTextField = .c
                            showKeyboard = true
                        }
                        .animation(.easeInOut)
                }
                
                Button("Solve") {
                    viewModel.Solve()
                    showKeyboard = false
                    viewModel.selectedTextField = .no
                    
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
                .padding(.horizontal, 120)
                .padding()
                .font(.system(size: 32))
                .foregroundColor(.white)
                .background(.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.vertical)
                .opacity(0.8)
                
                Text(viewModel.resultText)
                    .font(.system(size: 25))
                    .frame(width: UIScreen.screenWidth - 30)
                    .frame(height: UIScreen.screenHeight / 3 + 20)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
                Spacer()
            }
            .onTapGesture {
                showKeyboard = false
            }
            .animation(.easeInOut)
            SquareEqsKeyboardView(isShowing: $showKeyboard)
        }
    }
}

struct SquareEqsView_Previews: PreviewProvider {
    static var previews: some View {
        SquareEqsView(isPresented: .constant(true))
            .environmentObject(SquareEqsViewModel())
    }
}
