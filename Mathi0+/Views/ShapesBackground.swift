//
//  CircleBackground.swift
//  Mathi0+
//
//  Created by Artemiy Mirotvortsev on 11.02.2022.
//

import SwiftUI

struct ShapesBackground: View {
    
    var pos1: [CGFloat]
    var pos2: [CGFloat]
    var pos3: [CGFloat]
    
    init() {
        pos1 = definePosForRand(number: 1)
        pos2 = definePosForRand(number: 2)
        pos3 = definePosForRand(number: 3)
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.5)
                .ignoresSafeArea()
            CircleForBack(positions: pos1)
            CircleForBack(positions: pos2)
            CircleForBack(positions: pos3)
        }
        .blur(radius: 9)
    }
}

struct CircleForBack: View {
    
    @State var positions: [CGFloat]
    
    @State var _frame = CGFloat.random(in: 100...250)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors: [Color] = [Color.random, Color.random, Color.random]
    
    var body: some View {
        Circle()
            .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: _frame, height: _frame)
            .position(x: CGFloat.random(in: positions[0]...positions[1]), y: CGFloat.random(in: positions[2]...positions[3]))
            .shadow(color: .gray, radius: 20)
            .animation(.easeIn(duration: 6).repeatForever()).onReceive(timer, perform: { _ in
                _frame -= 50
                _frame += 50
            })
    }
}

func definePosForRand(number: Int) -> [CGFloat] {
    switch number {
    case 1:
        return [50, UIScreen.screenWidth / 3 - 50, 50, UIScreen.screenHeight / 3 - 50]
    case 2:
        return [UIScreen.screenWidth / 3 - 50, 2 * UIScreen.screenWidth / 3 - 50, UIScreen.screenHeight / 3 - 50, 2 * UIScreen.screenHeight / 3 - 50]
    case 3:
        return [2 * UIScreen.screenWidth / 3 - 50, UIScreen.screenWidth - 50, 2 * UIScreen.screenHeight / 3 - 50, UIScreen.screenHeight - 50]
    default:
        return [0, 0, 0, 0]
    }
}

//struct TriangleForBack: View {
//    @State var startPos = CGFloat.random(in: 0...200)
//    var body: some View {
//        ZStack {
//            Path { path in
//                path.move(to: CGPoint(x : startPos, y : startPos - 100))
//                path.addLine (to : CGPoint(x: startPos + 100, y : startPos))
//                path.addLine (to : CGPoint(x: startPos - 100, y : startPos))
//                path.addLine (to : CGPoint(x: startPos, y : startPos - 100))
//            }
//            .fill(LinearGradient(colors: [.random, .random, .random], startPoint: .topLeading, endPoint: .bottomTrailing))
//            Path { path in
//                path.move(to: CGPoint(x : startPos, y : startPos - 100))
//                path.addLine (to : CGPoint(x: startPos + 100, y : startPos))
//                path.addLine (to : CGPoint(x: startPos - 100, y : startPos))
//                path.addLine (to : CGPoint(x: startPos, y : startPos - 100))
//            }
//            .fill(.white)
//        }
//    }
//}

struct CircleBackground_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBackground()
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    static var random1: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: 0
        )
    }
    static var random2: Color {
        return Color(
            red: .random(in: 0...1),
            green: 0,
            blue: .random(in: 0...1)
        )
    }
    static var random3: Color {
        return Color(
            red: 0,
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
