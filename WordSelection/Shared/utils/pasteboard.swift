//
//  pasteboard.swift
//  WordSelection
//
//  Created by shiwx on 9/12/21.
//

import Foundation
import AppKit

func getPasteboard() -> String? {
#if os(iOS)
    return UIPasteboard.general.string
#endif
    return NSPasteboard.general.string(forType: .string)
}
