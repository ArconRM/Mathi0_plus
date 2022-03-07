//
//  ConverterView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 17.02.2022.
//

import SwiftUI

struct ConverterView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ConverterViewModel
    
    @State var selection1: String = ""
    @State var selection2: String = ""
    @State var selectionType: String = ""
    
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
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Spacer()
                    
                    Button {
                        viewModel.Swap()
                        
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Label("", systemImage: "arrow.up.arrow.down.circle")
                            .font(.system(size: UIScreen.screenHeight / 26))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                }
                    .padding(.top, 40)

                Text(viewModel.number1Text)
                    .frame(height: 70)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                    .cornerRadius(5)
                    .opacity(0.8)
                    .padding(.vertical)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.selectedTextField = .a
                            showKeyboard = true
                        }
                    }
                    .onChange(of: viewModel.number1Text) { newValue in
                        viewModel.Number1Changed()
                    }
                
                Picker(selection: $viewModel.value1, label: Text(viewModel.value1)) {
                    ForEach(viewModel.DefineValues(), id: \.self) { value in
                        Text(value)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .onChange(of: viewModel.value1) { V in
                    viewModel.Value1Changed()
                    
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
                
                Text(viewModel.number2Text)
                    .frame(height: 70)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: UIScreen.screenHeight / 26))
                    .background(viewModel.selectedTextField == .a ? Color.white.opacity(0.5) : Color.white)
                    .cornerRadius(5)
                    .opacity(0.8)
                    .padding(.vertical)
                    .padding(.horizontal, 20)
                
                Picker(selection: $viewModel.value2, label: Text(viewModel.value2)) {
                    ForEach(viewModel.DefineValues(), id: \.self) { value in
                        Text(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .onChange(of: viewModel.value2) { V in
                    viewModel.Value2Changed()
                    
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
                
                Spacer()
                
                Picker(selection: $viewModel.valuesType, label: Text(viewModel.valuesType.rawValue)) {
                    ForEach(TypesOfValues.allCases, id: \.self) { value in
                        Text(value.rawValue)
                            .font(.system(size: UIScreen.screenHeight / 34))
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            Spacer()
            
            ConverterKeyboardView(isShowing: $showKeyboard)
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView(isPresented: .constant(true))
            .environmentObject(ConverterViewModel())
    }
}
