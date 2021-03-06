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
    @Environment(\.colorScheme) var colorScheme
    
    let buttons: [[CalcButtons]] = [
        [.clear, .negative, .percent, .factorial],
        [.sqrt, .square, .cube, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
            VStack {
                HStack{
                    Button {
                        withAnimation(.easeInOut) {
                            isPresented = false
                        }
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Text("<")
                            .font(.system(size: UIScreen.screenHeight / 20))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .bold()
                            .padding()
                            .padding(.top, 40)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.Delete()
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.prepare()
                        generator.impactOccurred()
                    } label: {
                        Label("", systemImage: "delete.left.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.system(size: UIScreen.screenHeight / 20))
                    }
                    .padding(.top, 40)
                }
                
                HStack {
                    Text(viewModel.operationText)
                        .font(.system(size: UIScreen.screenHeight / 20))
                        .padding(.leading)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(viewModel.resultText)
                        .padding([.bottom, .trailing])
                        .font(.system(size: CGFloat(viewModel.DefineFontSize())))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.Solve(item: item)
                                
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.prepare()
                                generator.impactOccurred()
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(CalcButtonStyle(item: item, color: viewModel.DefineColor(item: item), count: viewModel.resultText.count))
                        }
                    }
                }
            }
            .padding(.bottom, 35)
        }
    }
}


struct CalcButtonStyle: ButtonStyle {
    
    var item: CalcButtons
    var color: Color
    var count: Int
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: item == CalcButtons.zero ? UIScreen.screenWidth / 2.6 : UIScreen.screenWidth / 7.3, height: UIScreen.screenHeight / 15.7, alignment: .center)
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
.previewInterfaceOrientation(.portrait)
    }
}
