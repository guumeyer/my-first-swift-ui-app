//
//  HomeView.swift
//  FirstApp
//
//  Created by meyer on 2022-01-12.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Watching")
    //                    .font(.system(size: 20, weight: .bold))
                        .modifier(CustomFontModifier(size: 20))
                    
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: { self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
//                            .renderingMode(.original)
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingViews()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent.toggle()
                        }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(
                                        Angle(
                                            // -30 remove initial value from geometry minX
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / -20 /* Smooth the animation */
                                        ),
                                        axis: (x: 5.0, y: 60.0, z: 10.0))
    //                                    Angle(
    //                                        degrees: geometry.frame(in: .global).minX / 20
    //                                    ),
    //                                    axis: (x: 10.0, y: 10.0, z: 10.0))
                            }
                            .frame(width: 275, height: 275)
                            
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30) // Move -30 up
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[1], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                Spacer()
            }
            .frame(width: screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype design in Swift UI", text: "18 Sections", logo: "Logo1", image: Image("Card2"), color: Color("card2")),
    Section(title: "Build Swift UI", text: "20 Sections", logo: "Logo1", image: Image("Card3"), color: Color("card3")),
    Section(title: "Swift UI Advance", text: "15 Sections", logo: "Logo1", image: Image("Card4"), color: Color("card4")),
    Section(title: "Swift UI Advance 2", text: "15 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card2")),
    Section(title: "Swift UI Advance 3", text: "15 Sections", logo: "Logo1", image: Image("Card5"), color: Color("card3")),
    Section(title: "Swift UI Advance 4", text: "15 Sections", logo: "Logo1", image: Image("Card6"), color: Color("card4"))
]

struct WatchRingViews: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(
                    color1: #colorLiteral(red: 0.482652545, green: 0.2100374699, blue: 1, alpha: 1),
                    color2: #colorLiteral(red: 0.2408812046, green: 0.6738553047, blue: 1, alpha: 1),
                    width: 44,
                    height: 44,
                    percent: 68,
                    delay: 0.3,
                    show: .constant(true)
                )
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .bold()
                        .modifier(FontModifier(style: .subheadline))
                    
                    
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(
                    color1: #colorLiteral(red: 0.8085320592, green: 0.02182126231, blue: 0.3457722068, alpha: 1),
                    color2: #colorLiteral(red: 0.9435996413, green: 0.3427492678, blue: 0.197148174, alpha: 1),
                    width: 32,
                    height: 32,
                    percent: 54,
                    delay: 0.3,
                    show: .constant(true)
                )
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(
                    color1: #colorLiteral(red: 0.4771556854, green: 0.8402735591, blue: 0.9841188788, alpha: 1),
                    color2: #colorLiteral(red: 0.5499526858, green: 0.3519915342, blue: 0.9708355069, alpha: 1),
                    width: 32,
                    height: 32,
                    percent: 32,
                    delay: 0.3,
                    show: .constant(true)
                )
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
