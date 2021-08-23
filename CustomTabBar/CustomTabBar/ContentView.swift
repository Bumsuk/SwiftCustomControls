//
//  ContentView.swift
//  CustomTabBar
//
//  Created by brown on 2021/08/21.
//

import SwiftUI

struct TabBarIcon: View {
    // @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var viewRouter: ViewRouter

    let assignedPage: Page
    
    let width, height: CGFloat
    let systemIconName, tabName: String

    var isSelected: Bool { viewRouter.currentPage == assignedPage }
    
    var body: some View {
        VStack {
            Group {
                Image(systemName: systemIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                Text(tabName)
                    .font(.footnote)
            }
            .foregroundColor(isSelected ? .blue : .white)

            Spacer()
        }
        .onTapGesture(count: 1) {
            withAnimation {
                viewRouter.currentPage = assignedPage
            }
        }
        /*
        .gesture(TapGesture().onEnded { _ in
        })
        */
    }
}

extension View {
    func applyTranstion() -> some View {
        self.transition(.asymmetric(insertion: .slide.combined(with: .scale(scale: 0.5)),
                                    removal: .move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.8))))
            .animation(.easeInOut)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - ContentView

struct ContentView: View {
    // @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showPopUp = false
    
    var body: some View {
        GeometryReader { proxy in
            let tabContainerHeight = proxy.size.height/10
            let tabWidth = proxy.size.width/5
            let tabHeight = proxy.size.height/30

            VStack(spacing: 0) {
                // 상단 컨텐츠 영역
                Group {
                    switch viewRouter.currentPage {
                    case .home:
                        Text("Home").applyTranstion().background(Color.blue)
                    case .liked:
                        Text("Liked").applyTranstion().background(Color.red)
                    case .records:
                        Text("Records").applyTranstion().background(Color.yellow)
                    case .user:
                        Text("User").applyTranstion().background(Color.purple)
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height - tabContainerHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //Spacer()
                // 탭바 컨텐츠 영역
                ZStack {
                    if showPopUp {
                        PlusMenu(widthAndHeight: 50)
                            .transition(.scale(scale: 0.5).combined(with: .opacity))
                            //.transition(.move(edge: .bottom))
                            .offset(y: -proxy.size.height/6)
                    }
                    HStack(spacing: 0) {
                        TabBarIcon(assignedPage: .home, width: tabWidth, height: tabHeight, systemIconName: "homekit", tabName: "Home")
                        TabBarIcon(assignedPage: .liked, width: tabWidth, height: tabHeight, systemIconName: "heart", tabName: "liked")

                        // TabBarIcon(width: proxy.size.width/5, height: proxy.size.height/28, systemIconName: "plus", tabName: "Add")
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: proxy.size.width/7, height: proxy.size.width/7)
                                .shadow(radius: 4)

                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: proxy.size.width/7 - 6, height: proxy.size.width/7 - 6)
                                .foregroundColor(Color("DarkPurple"))
                                .rotationEffect(.degrees(showPopUp ? 90 : 0))
                                .transaction { transaction in
                                    transaction.animation = .interactiveSpring(response: 0.60,
                                                                               dampingFraction: 0.40,
                                                                               blendDuration: 0.25)
                                                            .speed(2)
                                }
                                .onTapGesture {
                                    withAnimation(.interpolatingSpring(mass: 0.14, stiffness: 4, damping: 2, initialVelocity: 10).speed(3)) {
                                        showPopUp.toggle()
                                    }
                                }
                        }
                        .offset(x: 0, y: -tabContainerHeight/2)

                        TabBarIcon(assignedPage: .records, width: tabWidth, height: tabHeight, systemIconName: "waveform", tabName: "Records")
                        TabBarIcon(assignedPage: .user, width: tabWidth, height: tabHeight, systemIconName: "person.crop.circle", tabName: "Account")
                    }
                }
                .frame(width: proxy.size.width, height: tabContainerHeight, alignment: .center)
                .background(Color("TabBarBackground").shadow(radius: 2))
            }
            //.ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(viewRouter: ViewRouter())
        ContentView()
            .environmentObject(ViewRouter())
            .preferredColorScheme(.dark)
    }
}
