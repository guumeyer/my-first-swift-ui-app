//
//  HomeView.swift
//  FirstApp
//
//  Created by meyer on 2022-01-12.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var menuViewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile)
            .padding(.top, 44)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(
                // divide by 10 for menuViewState have less influence into rotation3DEffect
                Angle(
                    degrees: showProfile ? Double(menuViewState.height / 10) - 10 : 0),
                axis: (x: 10.0, y: 0, z: 0)  )
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
            .edgesIgnoringSafeArea(.all)
            
            
            MenuView()
                .background(Color.black.opacity(0.001)) // Keep background interactive, if change to 0 the onTapGesture wont work
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: menuViewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.menuViewState = value.translation
                        }
                        .onEnded { value in
                            if (menuViewState.height > 50) {
                                // dismiss the menu view
                                showProfile = false
                            }
                            
                            self.menuViewState = .zero
                        }
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
