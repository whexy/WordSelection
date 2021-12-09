//
//  FlexViewModel.swift
//  WordSelection
//
//  Created by shiwx on 7/12/21.
//

import Foundation


// Convert a sentence to word list
func toWordlist(sentence: String) -> [String] {
    // For now, only split by spaces. We can do further things with regex expr.
    let rawComponents = sentence.components(separatedBy: " ");
    
    let components = rawComponents.map { word in
        word.replacingOccurrences(of: "[^A-Za-z]", with: "", options: .regularExpression)
    }
    
    return components
}
