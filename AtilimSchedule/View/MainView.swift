//
//  MainView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI

struct MainView: View {
    
    
    @State private var isAddExamViewPresented: Bool = false
    @State private var isShowExamViewPresented: Bool = false
    @State private var isShowCoursesViewPresented: Bool = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        NavigationView {
            ZStack {
                AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.red]), center: .center)
                    .blur(radius: 4)
                    .ignoresSafeArea()
                
                
                ScrollView {
                    VStack {
                        HStack {
                            Text("Control your\nCourses & Exams")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Image("mainimage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenSize.height * 0.2)
                                .offset(x: 10)
                        }
                        .padding()
                        
                        
                        
                        Spacer(minLength: 50)
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                
                                Button {
                                    isShowCoursesViewPresented.toggle()
                                } label: {
                                    ActionCard(title: "Add Courses", icon: "book.fill", bgColor: .blue, image: "study1")
                                }
                                .sheet(isPresented: $isShowCoursesViewPresented, content: {
                                    CoursesView()
                                })
                                
                                NavigationLink {
                                    EditCoursesView()
                                } label: {
                                    ActionCard(title: "Edit Courses", icon: "pencil.circle.fill", bgColor: .green, image:"addcourse1")
                                }
                                
                                
                            }
                            .padding()
                            
                            HStack(spacing: 20) {
                                
                                Button {
                                    isAddExamViewPresented.toggle()
                                } label: {
                                    ActionCard(title: "Add Exams", icon: "calendar.badge.plus", bgColor: .orange, image: "exam")
                                }
                                .sheet(isPresented: $isAddExamViewPresented) {
                                    AddExamView() 
                                }
                                
                                Button {
                                    isShowExamViewPresented.toggle()
                                } label: {
                                    ActionCard(title: "Exams Dates", icon: "doc.text.fill", bgColor: .pink, image: "addhome")
                                    
                                }
                                .sheet(isPresented: $isShowExamViewPresented, content: {
                                    ExamDatesView()
                                })
                                
                                
                            }
                            .padding(.top, 60)
                        }
                        .padding()
                        .padding(.horizontal)
                        
                        Spacer(minLength: 10)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ActionCard: View {
    var title: String
    var icon: String
    var bgColor: Color
    var image : String
    
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        ZStack {
            bgColor
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            
            VStack {
                Spacer()
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.bottom, 20)
            }

            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.18)
                .offset(y: -75)  // Adjust this offset to position the image as needed
        }
        .frame(width: screenSize.width * 0.4, height: screenSize.height * 0.17)
    }
}


#Preview {
    MainView()
}
