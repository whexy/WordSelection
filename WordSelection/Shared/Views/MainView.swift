//
//  MainView.swift
//  WordSelection
//
//  Created by shiwx on 8/12/21.
//

import SwiftUI

struct MainView: View {
    @State var sen: String = ""
    @State var isActive: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                TextEditor(text: $sen)
                    .frame(height:100)
                    .border(.gray, width: 1)
                    .padding()
                    .onAppear {
                        if let pasteboardString = getPasteboard() {
                            sen = pasteboardString
                        }
                    }
                Button {
                    if let pasteboardString = getPasteboard() {
                        sen = pasteboardString
                    }
                } label: {
                    Label("Refresh from Clipboard", systemImage: "doc.on.clipboard")
                }
                
                NavigationLink(destination:  SelectionView(data: toWordlist(sentence: sen), content: toWordView, spacing: 15), isActive: $isActive) {
                    Button(action: {isActive = true}) {
                        Label("Submit", systemImage: "doc.text.magnifyingglass")
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
