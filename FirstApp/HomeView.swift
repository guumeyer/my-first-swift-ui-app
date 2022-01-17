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
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: $showProfile)
                
                Button(action: { self.showUpdate.toggle() }) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(.white)
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
            
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
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
        .frame(width: 275, height: 275)
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
