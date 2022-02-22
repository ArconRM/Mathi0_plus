//
//  SystemsView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 21.02.2022.
//

import SwiftUI

struct SystemsView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: SystemsViewModel
    
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
                        .font(.system(size: 40))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showChooseView = false
                            viewModel.showSystems = true
                        }
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Text("Convert")
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
                            viewModel.showSystemsOperations = true
                        }
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Text("Operations")
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
            } else if viewModel.showSystems {
                VStack {
                    HStack {
                        Button("<") {
                            withAnimation(.easeInOut) {
                                viewModel.showSystems = false
                                viewModel.showChooseView = true
                                viewModel.showKeyboard = false
                                viewModel.Clear()
                            }
                            
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.prepare()
                            generator.impactOccurred()
                        }
                        .padding(.leading, 30)
                        .padding(.top, 40)
                        .font(.system(size: 40))
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
                        .font(.system(size: 30))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Text(viewModel.aText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 340.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .a
                                viewModel.showKeyboard = true
                            }
                        }
                    
                    Picker(selection: $viewModel.system1, label: Text(viewModel.system1.rawValue)) {
                        ForEach(Systems.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxHeight: 30)
                    .padding(.vertical, 60)
                    
                    Button("Solve") {
                        viewModel.SolveSystems()
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
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .background(.black.opacity(0.8))
                    .cornerRadius(20)
                    .padding(.vertical)
                    .opacity(0.8)
                    
                    Picker(selection: $viewModel.system2, label: Text(viewModel.system2.rawValue)) {
                        ForEach(Systems.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxHeight: 30)
                    .padding(.vertical, 60)
                    
                    Text(viewModel.resultText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 340.0)
                        .font(.system(size: 30))
                        .background(Color.white)
                        .cornerRadius(5)
                        .opacity(0.8)
                    
                    Spacer()
                }
            } else if viewModel.showSystemsOperations {
                VStack {
                    HStack {
                        Button("<") {
                            withAnimation(.easeInOut) {
                                viewModel.showSystems = false
                                viewModel.showChooseView = true
                                viewModel.showKeyboard = false
                                viewModel.Clear()
                            }
                            
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.prepare()
                            generator.impactOccurred()
                        }
                        .padding(.leading, 30)
                        .padding(.top, 20)
                        .font(.system(size: 40))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Spacer()
                        
                        Button("Clear") {
                            viewModel.Clear()
                            
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.prepare()
                            generator.impactOccurred()
                        }
                        .padding(.trailing, UIScreen.screenWidth / 3)
                        .padding(.top, 20)
                        .font(.system(size: 30))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Text(viewModel.aText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 340.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .a
                                viewModel.showKeyboard = true
                            }
                        }
                    
                    Picker(selection: $viewModel.operation, label: Text(viewModel.operation.rawValue)) {
                        ForEach(Operations.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxHeight: 30)
                    .padding(.vertical, 50)
                    
                    Text(viewModel.bText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 340.0)
                        .font(.system(size: 30))
                        .background(viewModel.selectedTextField == .b ? Color.white.opacity(0.5) : Color.white)
                        .cornerRadius(5)
                        .opacity(0.8)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTextField = .b
                                viewModel.showKeyboard = true
                            }
                        }
                    
                    HStack {
                        Text("in")
                            .font(.system(size: 25))
                        
                        Picker(selection: $viewModel.system1, label: Text(viewModel.system1.rawValue)) {
                            ForEach(Systems.allCases, id: \.self) { value in
                                Text(value.rawValue)
                            }
                        }
                        .pickerStyle(.inline)
                        .frame(maxHeight: 30)
                        .frame(maxWidth: 70)
                        .padding(.vertical, 60)
                        .padding(.leading, 60)
                        
                        Text("system")
                            .font(.system(size: 25))
                    }
                    
                    Button("Count") {
                        viewModel.SolveSystemsOpeations()
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
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .background(.black.opacity(0.8))
                    .cornerRadius(20)
                    .opacity(0.8)
                    
                    Text(viewModel.resultText)
                        .frame(height: 70)
                        .foregroundColor(.black)
                        .frame(width: 340.0)
                        .font(.system(size: 30))
                        .background(Color.white)
                        .cornerRadius(5)
                        .opacity(0.8)
                    
                    Spacer()
                }
            }
            SystemsKeyboardView(isShowing: $viewModel.showKeyboard)
        }
    }
}

struct SystemsView_Previews: PreviewProvider {
    static var previews: some View {
        SystemsView(isPresented: .constant(true))
            .environmentObject(SystemsViewModel())
    }
}
