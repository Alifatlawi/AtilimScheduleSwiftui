//
//  CustomeTabBar.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI

enum Tab : String, CaseIterable {
    case house
    case calendar
    case gearshape
    case link
}

struct CustomeTabBar: View {
    @Binding var selectedTab : Tab
    var body: some View {
        VStack{
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundStyle(selectedTab == tab ? Color.blue : Color.gray)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(30)
            .padding()
        }
    }
}

#Preview {
    CustomeTabBar(selectedTab: .constant(.house))
}
