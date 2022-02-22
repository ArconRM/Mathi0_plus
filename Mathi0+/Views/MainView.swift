//
//  MainView.swift
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
    case Systems = "Number\n systems"
    case MultDec = "Multiplier\n decomposition"
    case Trig = "Trigonometry"
}

struct MainView: View {
    
    @State var showCalc: Bool = false
    @State var showSquareEqs: Bool = false
    @State var showLCM_GCD: Bool = false
    @State var showMultipliers: Bool = false
    @State var showTrigonometry: Bool = false
    @State var showConverter: Bool = false
    @State var showPifagor: Bool = false
    @State var showSystems: Bool = false
    @State var backgroundSelection: Backgrounds = .Shapes
    
    let backgrounds: [Backgrounds] = [.Gradient, .Shapes]
    let buttons: [[MainViewButtons]] =
    [
        [.Calc, .Pifagor],
        [.SquareEq, .LCM_GCD],
        [.Conv, .Systems],
        [.MultDec, .Trig]
    ]
    
    var body: some View {
        ZStack {
//            switch backgroundSelection {
//            case .Shapes:
//                ShapesBackground()
//                    .ignoresSafeArea()
//            case .Gradient:
//                GradientBackground()
//                    .blur(radius: 10)
//                    .ignoresSafeArea()
//            }
            if showCalc {
                CalcView(isPresented: $showCalc)
                    .environmentObject(CalcViewModel())
            } else if showSquareEqs {
                SquareEqsView(isPresented: $showSquareEqs)
                    .environmentObject(SquareEqsViewModel())
            } else if showLCM_GCD {
                LCM_GCD_View(isPresented: $showLCM_GCD)
                    .environmentObject(LCM_GCD_ViewModel())
            } else if showMultipliers {
                MultipliersView(isPresented: $showMultipliers)
                    .environmentObject(MultipliersViewModel())
            } else if showTrigonometry {
                TrigonometryView(isPresented: $showTrigonometry)
                    .environmentObject(TrigonometryViewModel())
            } else if showConverter {
                ConverterView(isPresented: $showConverter)
                    .environmentObject(ConverterViewModel())
            } else if showPifagor {
                PifagorView(isPresented: $showPifagor)
                    .environmentObject(PifagorViewModel())
            } else if showSystems {
                SystemsView(isPresented: $showSystems)
                    .environmentObject(SystemsViewModel())
            } else {
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
                                    } else if item == .LCM_GCD {
                                        withAnimation(.easeInOut) {
                                            showLCM_GCD.toggle()
                                        }
                                    } else if item == .MultDec {
                                        withAnimation(.easeInOut) {
                                            showMultipliers.toggle()
                                        }
                                    } else if item == .Trig {
                                        withAnimation(.easeInOut) {
                                            showTrigonometry.toggle()
                                        }
                                    } else if item == .Conv {
                                        withAnimation(.easeInOut) {
                                            showConverter.toggle()
                                        }
                                    } else if item == .Pifagor {
                                        withAnimation(.easeInOut) {
                                            showPifagor.toggle()
                                        }
                                    } else if item == .Systems {
                                        withAnimation(.easeInOut) {
                                            showSystems.toggle()
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
                            }
                        }
                    }
                    Spacer()
                }
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
