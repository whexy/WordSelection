//
//  DictionaryCard.swift
//  WordSelection
//
//  Created by shiwx on 7/12/21.
//

import SwiftUI


struct DictionaryCard: View {
    @State var word: String
    //    @StateObject var dic : DicTool
    @State private var phone: String = ""
    @State private var trans: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text(word)
                .font(.system(size: 28))
            HStack {
                Text("/\(phone)/")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(trans)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }.task {
            // define result structures
            struct Result: Codable {
                let simple: Simple
                let web_trans: WebTrans
            }
            
            struct Simple: Codable {
                let word: [SimpleWord]
            }
            
            struct SimpleWord: Codable {
                let ukphone: String
                let usphone: String
            }
            
//            struct RelWord: Codable {
//                let rels: [RelCell]
//            }
//
//            struct RelCell: Codable {
//                let rel: Rel
//            }
//
//            struct Rel: Codable {
//                let pos: String
//                let words: [Word]
//            }
//
//            struct Word: Codable {
//                let tran: String
//            }

            struct WebTrans: Codable {
                enum CodingKeys: String, CodingKey {
                    case web_translation = "web-translation"
                }
                let web_translation: [Translation]
            }
            
            struct Translation: Codable {
                let trans: [Trans]
            }
            
            struct Trans: Codable {
                let value: String
            }

            
            do {
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://dict.youdao.com/jsonapi?q=\(word)")!)
                let result = try JSONDecoder().decode(Result.self, from: data)
                self.phone = result.simple.word[0].usphone
//                self.trans = result.rel_word.rels[0].rel.words[0].tran
                self.trans = result.web_trans.web_translation.flatMap({trans in
                    trans.trans.map({tran in
                        tran.value
                    })
                }).prefix(5).joined(separator: ";")
            }
            catch {
                
            }
        }
        
    }
}

struct DictionaryCard_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryCard(word: "fuck")
    }
}
