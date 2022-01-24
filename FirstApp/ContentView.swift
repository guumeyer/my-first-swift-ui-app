//
//  ContentView.swift
//  FirstApp
//
//  Created by meyer on 2022-01-11.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var showCard = false
    @State var showBottomViewFull = false
    @State var viewState = CGSize.zero
    // used to ancher the view
    @State var bottomViewState = CGSize.zero
    let dismissBottomView: CGFloat = 50.0
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatForever(autoreverses: false)
                    ,value: showCard)
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees( show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: show)
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3), value: show)
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: showCard)
                .onTapGesture {
                    self.showCard.toggle()
                }.gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded { value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            // display the bottom view height position during the drag action
//            Text("\(bottomViewState.height)").offset(y: -300)
            
        BottomCardView(show: $showCard )
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomViewState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: bottomViewState)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomViewState = value.translation
                        }
                        . onEnded { Value in
                            if bottomViewState.height > self.dismissBottomView {
                                self.showCard = false
                                if self.showBottomViewFull {
                                    bottomViewState.height += -300
                                }
                                if bottomViewState.height < -300 {
                                    bottomViewState.height = -300
                                }
                            }
                            
                            if (bottomViewState.height < -100 && !self.showBottomViewFull) || ( bottomViewState.height < -270 && self.showBottomViewFull) {
                                self.bottomViewState.height  = -300
                                self.showBottomViewFull = true
                            } else {
                                self.bottomViewState = .zero
                                self.showBottomViewFull = false
                            }
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 100, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            Image("Background1")
            
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .background(.black)
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("This certificate proof that Gustavo has achived the UI Design course")
                .foregroundColor(Color("secondary"))
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                
                RingView(
                    color1: #colorLiteral(red: 0.2408812046, green: 0.6738553047, blue: 1, alpha: 1),
                    color2: #colorLiteral(red: 0.2206805944, green: 0.1452613175, blue: 0.8561988473, alpha: 1),
                    width: 88,
                    height: 88,
                    percent: 78,
                    delay: 0.3,
                    show: $show
                )
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI")
                        .fontWeight(.bold)
                    Text("12 of 12 section completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
//
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
