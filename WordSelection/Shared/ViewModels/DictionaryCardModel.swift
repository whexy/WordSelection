//
//  DictionaryCardModel.swift
//  WordSelection
//
//  Created by shiwx on 9/12/21.
//

import Foundation

enum DictionaryError: Error{
    case HTTPError
    case JSONDecodeError
    case JSONMissingError
}

class DictionaryModel: ObservableObject {
    @Published var word: String
    @Published var phone: String
    @Published var trans: String
    
    init(word: String, phone: String, trans: String) {
        self.word = word
        self.phone = phone
        self.trans = trans
    }
}

let DefaultDictionaryModel = DictionaryModel(word: "", phone: "--", trans: "--")

class YouDaoDictionary {
    var word: String
    private var url: URL { URL(string: "https://dict.youdao.com/jsonapi?q=\(self.word)")! }
    
    init(word: String) {
        self.word = word
    }
    
    func fetchDictionary() async throws -> DictionaryModel {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            print(response)
            throw DictionaryError.HTTPError
        }
        guard let result = try? JSONDecoder().decode(Result.self, from: data)
        else {
            throw DictionaryError.JSONDecodeError
        }
        let phone = result.simple.word[0].usphone
        let trans = result.web_trans.web_translation.flatMap({trans in
            trans.trans.map({tran in
                tran.value
            })
        }).prefix(5).joined(separator: ";")
        return DictionaryModel(word: word, phone: phone, trans: trans)
    }
    
    // MARK: define result structures of YouDao API
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
    struct RelWord: Codable {
        let rels: [RelCell]
    }
    struct RelCell: Codable {
        let rel: Rel
    }
    struct Rel: Codable {
        let pos: String
        let words: [Word]
    }
    struct Word: Codable {
        let tran: String
    }
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
}
