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
                TextField("Sentence", text: $sen)
                NavigationLink(destination:  FlexView(data: toWordlist(sentence: sen), content: toWordView, spacing: 15), isActive: $isActive) {
                    Button(action: {isActive = true}) {
                        Label("Submit", systemImage: "doc.text.magnifyingglass")
                    }
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
