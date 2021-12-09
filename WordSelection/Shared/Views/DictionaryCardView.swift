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
            Text(word)
                .font(.system(size: 28))
            HStack {
                Text("/\(dictionaryModel.phone)/")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(dictionaryModel.trans)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
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
        DictionaryCardView(word: "fuck")
    }
}
