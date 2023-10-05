//
//  OnboardingView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/29/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        ZStack {
            if currentPage == 1 {
                ScreenView(
                    image: "study1",
                    title: "Organize Your Academic Life",
                    detail: "Ease your university life with a personalized schedule. Never miss a lecture or a study group meet-up.",
                    bgColor: Color("color1")
                )
                .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(
                    image: "study2",
                    title: "Never Miss a Class",
                    detail: "Set alarms for your classes and get reminders ahead of time. Be punctual and stay ahead in your academic journey.",
                    bgColor: Color("color2")
                )
                .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(
                    image: "exam",
                    title: "Stay Prepared for Exams",
                    detail: "Keep track of your exam dates and study schedules. Get notified in advance to start preparing.",
                    bgColor: Color("color3")
                )
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: currentPage)
        .overlay(alignment: .bottom) {
            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(Circle())
                    .overlay {
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                            
                        }
                        .padding(-15)
                    }
                    .padding(.bottom, 20)
            })
        }
    }
}


#Preview {
    OnboardingView()
}


struct ScreenView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack {
            HStack{
                
                if currentPage == 1 {
                    Text("Hello Students!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.2)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .clipShape(.rect(cornerRadius: 10))
                        
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundStyle(.black)
            .padding()
            
            //                Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(width: 350)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            
            
            Spacer(minLength: 150)
            
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
        
    }
}


var totalPages = 3
