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
                    viewModel.selectedTextField = .no
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
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Spacer()
                    }
                    Text("What do you need\n to find?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showChooseView = false
                            viewModel.showCatetView = true
                        }
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Text("Cathetus")
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.screenHeight / 8, alignment: .center)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                    .background(.white.opacity(0.5))
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .padding(.bottom)
                    .padding(.horizontal, 30)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showChooseView = false
                            viewModel.showGipotView = true
                        }
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Text("Hypotenuse")
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.screenHeight / 8, alignment: .center)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                    .background(.white.opacity(0.5))
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .padding(.bottom)
                    .padding(.horizontal, 30)
                    
                    Spacer()
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
                        .font(.system(size: UIScreen.screenHeight / 26))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .padding(.top, 40)
                    
                    HStack {
                        Text("a = ")
                            .font(.system(size: UIScreen.screenHeight / 21))
                            .padding()
                        
                        Text(viewModel.aText)
                            .frame(width: UIScreen.screenWidth - 115)
                            .frame(height: UIScreen.screenHeight / 13)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                            .cornerRadius(5)
                            .padding(.trailing, 20)
                            .opacity(0.8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedTextField = .a
                                    viewModel.showKeyboard = true
                                }
                            }
                    }
                    
                    HStack {
                        Text("b = ")
                            .font(.system(size: UIScreen.screenHeight / 21))
                            .padding()
                        
                        Text(viewModel.bText)
                            .frame(width: UIScreen.screenWidth - 115)
                            .frame(height: UIScreen.screenHeight / 13)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .background(viewModel.selectedTextField == .b ? Color.white.opacity(0.5) : Color.white)
                            .cornerRadius(5)
                            .padding(.trailing, 20)
                            .opacity(0.8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedTextField = .b
                                    viewModel.showKeyboard = true
                                }
                            }
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
                        .frame(height: UIScreen.screenHeight / 3 + 20)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
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
                        .font(.system(size: UIScreen.screenHeight / 26))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .padding(.top, 40)
                    
                    HStack {
                        Text("a = ")
                            .font(.system(size: UIScreen.screenHeight / 21))
                            .padding()
                        
                        Text(viewModel.aText)
                            .frame(width: UIScreen.screenWidth - 115)
                            .frame(height: UIScreen.screenHeight / 13)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                            .cornerRadius(5)
                            .padding(.trailing, 20)
                            .opacity(0.8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedTextField = .a
                                    viewModel.showKeyboard = true
                                }
                            }
                    }
                    
                    HStack {
                        Text("c = ")
                            .font(.system(size: UIScreen.screenHeight / 21))
                            .padding()
                        
                        Text(viewModel.cText)
                            .frame(width: UIScreen.screenWidth - 115)
                            .frame(height: UIScreen.screenHeight / 13)
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .background(viewModel.selectedTextField == .c ? Color.white.opacity(0.5) : Color.white)
                            .cornerRadius(5)
                            .padding(.trailing, 20)
                            .opacity(0.8)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedTextField = .c
                                    viewModel.showKeyboard = true
                                }
                            }
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
                        .frame(height: UIScreen.screenHeight / 3 + 20)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
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
