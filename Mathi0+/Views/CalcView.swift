//
//  CalcView.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 12.02.2022.
//

import SwiftUI

struct CalcView: View {
    
    @EnvironmentObject var viewModel: CalcViewModel
    //    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    let buttons: [[CalcButtons]] = [
        [.clear, .negative, .percent, .factorial],
        [.sqrt, .square, .cube, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .comma, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                HStack{
                    Button {
                        isPresented = false
                    } label: {
                        Text("<")
                            .font(.system(size: 40))
                            .bold()
                            .padding()
                    }
                    Spacer()
                    
                }
                HStack {
                    Text(viewModel.operationText)
                        .font(.system(size: 55))
                        .padding()
                    
                    Spacer()
                    
                    Text(viewModel.resultText)
                        .padding()
                        .font(.system(size: 55))
                }
                
                Spacer()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.solve(item: item)
                                
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.prepare()
                                generator.impactOccurred()
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: CGFloat(viewModel.defineFontSize())))
                            }
                            .buttonStyle(CalcButtonStyle(item: item, color: viewModel.defineColor(item: item), count: viewModel.resultText.count))
                        }
                    }
                }
            }
        }
    }
}


struct CalcButtonStyle: ButtonStyle {
    
    var item: CalcButtons
    var color: Color
    var count: Int
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: item == CalcButtons.zero ? 141 : 51, height: 50, alignment: .center)
            .padding()
            .foregroundColor(.black)
            .background(configuration.isPressed ? color.opacity(0.4) : color)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.8), radius: 3, x: 1, y: 1)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}


struct CalcView_Previews: PreviewProvider {
    static var previews: some View {
        CalcView(isPresented: .constant(true))
            .environmentObject(CalcViewModel())
    }
}
