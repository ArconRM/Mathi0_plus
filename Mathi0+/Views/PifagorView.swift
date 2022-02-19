//
//  PifagorChooseView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 19.02.2022.
//

import SwiftUI

struct PifagorView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: PifagorViewModel
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.showKeyboard = false
                }
            if viewModel.showChooseView {
                VStack {
                    HStack {
                        Button("<") {
                            withAnimation(.easeInOut) {
                                isPresented = false
                                viewModel.showKeyboard = false
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
                    }
                    Text("What do you need\n to find?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showChooseView = false
                            viewModel.showCatetView = true
                        }
                    } label: {
                        Text("Cathetus")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .frame(width: 250, height: 90, alignment: .center)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                    .background(.white.opacity(0.5))
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .padding(.bottom)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showChooseView = false
                            viewModel.showGipotView = true
                        }
                    } label: {
                        Text("Hypotenuse")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .frame(width: 250, height: 90, alignment: .center)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                    .background(.white.opacity(0.5))
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .padding(.vertical)
                    .padding(.bottom, 70)
                    
                    Spacer()
                }
            } else if viewModel.showCatetView {
                VStack {
                    HStack {
                        Button("<") {
                            withAnimation(.easeInOut) {
                                viewModel.showCatetView = false
                                viewModel.showChooseView = true
                                viewModel.showKeyboard = false
                                viewModel.Clear()
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
                        Text("a = ")
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
                                viewModel.showKeyboard = true
                            }
                            .animation(.easeInOut)
                    }
                    
                    HStack {
                        Text("b = ")
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
                                viewModel.showKeyboard = true
                            }
                            .animation(.easeInOut)
                    }
                    
                    Button("Solve") {
                        viewModel.SolveGip()
                        withAnimation(.easeInOut) {
                            viewModel.showKeyboard = false
                        }
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
                    
                    Spacer()
                    
                    Text(viewModel.resultText)
                        .font(.system(size: 25))
                        .frame(width: UIScreen.screenWidth - 30)
                        .frame(height: UIScreen.screenHeight / 3 + 20)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .multilineTextAlignment(.center)
                }
            } else if viewModel.showGipotView {
                VStack {
                    HStack {
                        Button("<") {
                            withAnimation(.easeInOut) {
                                viewModel.showGipotView = false
                                viewModel.showChooseView = true
                                viewModel.showKeyboard = false
                                viewModel.Clear()
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
                        Text("a = ")
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
                                viewModel.showKeyboard = true
                            }
                            .animation(.easeInOut)
                    }
                    
                    HStack {
                        Text("c = ")
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
                                viewModel.showKeyboard = true
                            }
                            .animation(.easeInOut)
                    }
                    
                    Button("Solve") {
                        viewModel.SolveCath()
                        withAnimation(.easeInOut) {
                            viewModel.showKeyboard = false
                        }
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
                    
                    Spacer()
                    
                    Text(viewModel.resultText)
                        .font(.system(size: 25))
                        .frame(width: UIScreen.screenWidth - 30)
                        .frame(height: UIScreen.screenHeight / 3 + 20)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .multilineTextAlignment(.center)
                }
            }
            
            PifagorKeyboardView(isShowing: $viewModel.showKeyboard)
        }
    }
}

struct PifagorChooseView_Previews: PreviewProvider {
    static var previews: some View {
        PifagorView(isPresented: .constant(true))
            .environmentObject(PifagorViewModel())
    }
}
