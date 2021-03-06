//
//  SelectionView.swift
//  WordSelection
//  Created by shiwx on 7/12/21.
//

import SwiftUI

class ChosenWords: ObservableObject {
    @Published var chosenWords: Set<String> = []
    @Published var isEmpty: Bool = true
    
    func addWord(word: String) {
        chosenWords.insert(word)
        isEmpty = false
    }
    
    func removeWord(word: String) {
        chosenWords.remove(word)
        if chosenWords.isEmpty {
            isEmpty = true
        }
    }
}

struct SelectionView<Data: Collection, Content: View>: View
where Data.Element: Hashable
{
    let data: Data
    let content: (Data.Element) -> Content
    let spacing: CGFloat
    @State private var elementsSize: [Data.Element: CGSize] = [:]
    @State private var height: CGFloat = 0
    @StateObject var chosen = ChosenWords()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Group {
                    VStack(spacing: spacing) {
                        Color.clear.frame(height:spacing / 2)
                        ForEach(computeRows(width: geometry.size.width), id: \.self) { rowElements in
                            HStack(spacing: spacing) {
                                ForEach(rowElements, id: \.self) { element in
                                    content(element)
                                        .fixedSize()
                                        .readSize { size in
                                            elementsSize[element] = size
                                        }
                                }
                                Spacer()
                            }
                            .padding(.leading, 5)
                        }
                        Color.clear.frame(height:spacing)
                    }
                    .environmentObject(chosen)
                }
                .background(Color(red: 0.454, green: 0.454, blue: 0.5, opacity: 0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                ScrollView {
                    VStack {
                        ForEach(Array(chosen.chosenWords), id: \.self) { word in
                            DictionaryCardView(word: word)
                                .padding()
                        }
                        Group {
                            if !chosen.isEmpty {
                                Button {
                                    
                                } label: {
                                    Label("Add to Anki", systemImage: "plus.circle")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Choose a word")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func computeRows(width availableWidth: CGFloat) -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        var elementHeight: CGFloat = 0
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            // get a element's height, use it as a reference
            if elementHeight == 0 {
                elementHeight = elementSize.height
            }
            
            // create multiple rows
            if remainingWidth - elementSize.width - spacing >= 0 {
                rows[currentRow].append(element)
            } else {
                // start a new row
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            remainingWidth = remainingWidth - elementSize.width - spacing
        }
        return rows
    }
}

func toWordView(word: String) -> some View {
    return WordView(word: word)
}

struct WordView: View {
    let word: String
    @EnvironmentObject var chosen: ChosenWords
    @State private var isSelected : Bool = false
    var body: some View {
        Text(word)
            .foregroundColor(isSelected ? Color.white : Color.primary)
            .padding(8)
#if os(iOS)
            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(isSelected ? Color(uiColor: .systemBlue) : Color(uiColor: .secondarySystemFill)))
#endif
#if os(macOS)
            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(isSelected ? Color.blue : Color(nsColor: .secondaryLabelColor)))
#endif
            .onTapGesture {
                isSelected = !isSelected
                if (isSelected) {
                    chosen.addWord(word: word)
                } else {
                    chosen.removeWord(word: word)
                }
            }
    }
}

struct FlexView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(data: toWordlist(sentence: "Just as ecstasy purifies you of the particular and the contingent"), content: toWordView, spacing: 15)
    }
}
