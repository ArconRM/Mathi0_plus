//
//  ContentView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 06.02.2022.
//

import SwiftUI

enum Backgrounds: String {
    case Gradient = "Gradient"
    case Shapes = "Shapes"
}

enum MainViewButtons: String {
    case Calc = "Calculator"
    case Pifagor = "Pifagor\n Theoreme"
    case SquareEq = "Square\n Equations"
    case LCM_GCD = "LCM and GCD"
    case Conv = "Converter"
    case NumbSys = "Number\n systems"
    case MultDec = "Multiplier\n decomposition"
    case Trig = "Trigonometry"
}

struct MainView: View {
    
    @State var showCalc: Bool = false
    @State var showSquareEqs: Bool = false
    @State var backgroundSelection: Backgrounds = .Shapes
    
    let backgrounds: [Backgrounds] = [.Gradient, .Shapes]
    let buttons: [[MainViewButtons]] =
    [
        [.Calc, .Pifagor],
        [.SquareEq, .LCM_GCD],
        [.Conv, .NumbSys],
        [.MultDec, .Trig]
    ]
    
    var body: some View {
        ZStack {
            switch backgroundSelection {
            case .Shapes:
                ShapesBackground()
                    .ignoresSafeArea()
            case .Gradient:
                GradientBackground()
                    .ignoresSafeArea()
            }
            VStack {
                HStack {
                    Spacer()
                    
                    Picker(
                        selection: $backgroundSelection,
                        label: Label("", systemImage: "gear.circle.fill")
                            .foregroundColor(.black),
                        content: {
                            ForEach(backgrounds, id: \.self) { option in
                                Text(option.rawValue)
                                    .foregroundColor(.black)
                            }
                        })
                        .foregroundColor(.black)
                        .pickerStyle(MenuPickerStyle())
                }
                .padding()
                Text("Mathi0+")
                    .font(.system(size: 60))
                    .bold()
                Spacer()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button {
                                if item == .Calc {
                                    withAnimation(.easeOut) {
                                        showCalc.toggle()
                                    }
                                } else if item == .SquareEq {
                                    withAnimation(.easeOut) {
                                        showSquareEqs.toggle()
                                    }
                                }
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.prepare()
                                generator.impactOccurred()
                            } label: {
                                Text(item.rawValue)
                                    .foregroundColor(.black)
                                    .frame(width: 120, height: 50, alignment: .center)
                                    .padding()
                            }
                            .buttonStyle(.bordered)
                            .background(.white.opacity(0.5))
                            .cornerRadius(20)
                            .shadow(radius: 2)
                            .sheet(isPresented: $showCalc) {
                                CalcView(isPresented: $showCalc)
                                    .environmentObject(CalcViewModel())
                            }
                            .sheet(isPresented: $showSquareEqs) {
                                SquareEqsView(isPresented: $showSquareEqs)
                                    .environmentObject(SquareEqsViewModel())
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CalcViewModel())
    }
}
