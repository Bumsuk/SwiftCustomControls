//
//  ContentView.swift
//  CustomFloatMenu
//
//  Created by brown on 2021/08/22.
//

import SwiftUI

struct TouchEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct MenuItem: View {
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("MenuBackground"))
                .frame(width: 55, height: 55)
            
            Image(systemName: icon)
                .foregroundColor(.white)
                .imageScale(.large)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}

struct FloatingMenu: View {
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
        Button(action: {
            showMenu()
        }, label: {
            VStack {
                Spacer()
                
                if showMenuItem1 {
                    MenuItem(icon: "camera.fill")
                }
                if showMenuItem2 {
                    MenuItem(icon: "photo.on.rectangle")
                }
                if showMenuItem3 {
                    MenuItem(icon: "square.and.arrow.up.fill")
                }
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color("MenuBackground"))
                    .shadow(color: .gray.opacity(0.8), radius: 0.2, x: 1, y: 1)
            }
        })
        .transaction { transaction in
            transaction.animation = .easeIn
        }

    }
    
    private func showMenu() {
        withAnimation {
            showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                showMenuItem2.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                showMenuItem1.toggle()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.clear
            FloatingMenu()
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // MenuItem(icon: "camera.fill")
    }
}
