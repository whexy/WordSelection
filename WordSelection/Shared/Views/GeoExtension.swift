//
//  GeoExtension.swift
//  WordSelection
//  Extension of GeometryReader to read size without changing layout
//  See the blog [SwiftUI Share Layout Information](https://www.fivestars.blog/articles/swiftui-share-layout-information/)
//  Created by shiwx on 7/12/21.
//

import SwiftUI

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
