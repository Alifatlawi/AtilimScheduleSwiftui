//
//  LinkView.swift
//  CourseFinder
//
//  Created by Ali Amer on 9/30/23.
//

import SwiftUI

struct LinkView: View {
    @State private var showMailView = false
    var body: some View {
        NavigationView{
            List {
                profile
                
                links
                
                menu
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Links")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var menu: some View {
            Section {
                NavigationLink(destination: MailView(subject: "Message from App", toRecipients: ["ali.a.mardan@gmail.com"]), isActive: $showMailView) {
                    Label("Send me a message", systemImage: "message" )
                }
            }
            .listRowSeparatorTint(.blue)
            .listRowSeparator(.hidden)
        }
    
    var profile : some View {
        VStack(spacing: 8) {
            Image(systemName: "person")
                .symbolVariant(.circle.fill)
                .font(.system(size: 30))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x:-50, y: -100)
            )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            Text("Made by Ali Al-Fatlawi")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var links : some View {
        Section {
            Link(destination: URL(string: "https://www.atilim.edu.tr/en/dersprogrami")!, label: {
                HStack {
                    Label("Atilim Schedules", systemImage: "building.columns")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
            
            Link(destination: URL(string: "https://kimlik.atilim.edu.tr/#/")!, label: {
                HStack {
                    Label("Atacs", systemImage: "graduationcap.fill")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
            
            Link(destination: URL(string: "https://alifatlawi.github.io/cv/")!, label: {
                HStack {
                    Label("My website", systemImage: "person.fill")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .accentColor(.primary)
        }
    }
}

#Preview {
    LinkView()
}



import MessageUI

struct MailView: UIViewControllerRepresentable {
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode

    var subject: String
    var toRecipients: [String]

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(subject)
        vc.setToRecipients(toRecipients)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

