//
//  CardViewModel.swift
//  WordSelection
//
//  Created by shiwx on 7/12/21.
//

import Foundation


// Convert a sentence to word list
func toWordlist(sentence: String) -> [String] {
    // For now, only split by spaces. We can do further things with regex expr.
    return sentence.components(separatedBy: " ");
}
