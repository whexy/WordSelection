//
//  pasteboard.swift
//  WordSelection
//
//  Created by shiwx on 9/12/21.
//

import Foundation
#if os(iOS)
import UIKit
#endif
#if os(macOS)
import AppKit
#endif

func getPasteboard() -> String? {
#if os(iOS)
    return UIPasteboard.general.string
#endif
#if os(macOS)
    return NSPasteboard.general.string(forType: .string)
#endif
}
