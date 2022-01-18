//
//  CourseList.swift
//  FirstApp
//
//  Created by meyer on 2022-01-17.
//

import SwiftUI

struct CourseList: View {
    var body: some View {
        VStack {
            CourseView()
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @State var showFullScreenMode = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI Advanced")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text("20 Sections")
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Image("Logo1")
            }
            
            Spacer()
            
            Image("Card2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 140, alignment: .top)
        }
        .padding(showFullScreenMode ? 30 : 20)
        .padding(.top, showFullScreenMode ? 30 : 0)
//        .frame(width: show ? screen.width : (screen.width - 60), height: show ? screen.height : 280)
        .frame(maxWidth: showFullScreenMode ? .infinity : screen.width - 60, maxHeight: showFullScreenMode ? .infinity : 280)
        .background(Color(#colorLiteral(red: 0.482652545, green: 0.2100374699, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.3724882603, green: 0.1707983911, blue: 0.9676635861, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showFullScreenMode)
        .onTapGesture {
            showFullScreenMode.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
