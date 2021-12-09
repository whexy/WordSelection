//
//  DictionaryCardView.swift
//  WordSelection
//
//  Created by shiwx on 7/12/21.
//

import SwiftUI


struct DictionaryCardView: View {
    @State var word: String
    @State private var dictionaryModel : DictionaryModel = DefaultDictionaryModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(word)
                    .font(.system(size: 28))
                Spacer()
                Text("/\(dictionaryModel.phone)/")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            Text("\(dictionaryModel.trans)")
                .font(.system(size: 14))
                .fontWeight(.light)
            VStack(alignment: .leading) {
                ForEach(dictionaryModel.sent, id:\.self) { sent in
                    HStack {
                        Text(.init(sent))
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .padding()
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }.task {
            let youdao = YouDaoDictionary(word: word)
            guard let youdaoDictionaryModel = try? await youdao.fetchDictionary()
            else {
                // do something
                return
            }
            dictionaryModel = youdaoDictionaryModel
        }
    }
}

struct DictionaryCard_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryCardView(word: "illegally")
    }
}
