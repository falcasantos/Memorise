//
//  ContentView.swift
//  Memorise
//
//  Created by Robert Falcasantos on 2023-10-31.
//

import SwiftUI

struct ContentView: View {
    let vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🏎️", "🚓", "🚑", "🚒", "🚜", "🛵", "🛻"]
    let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁"]
    let buildingEmojis = ["🏠", "⛺️", "🏰", "🏟️", "🏥", "🏤", "🏛️", "🏦", "🏪", "🏫", "⛪️"]
    
    @State var emojis: Array<String> = []
    @State var theme: String = "Vehicles"
    @State var color: Color = .orange
    @State var cardCount = 0
    
    var cardWidth: CGFloat {
        if cardCount <= 9 {
            return 100
        } else if cardCount > 9 && cardCount < 18 {
            return 80
        } else {
            return 60
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardThemeChoosers
                .font(.title)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(color)
    }
    
    var cardThemeChoosers: some View {
        HStack {
            Spacer()
            cardThemeChooser(withName: "Vehicles", emojis: vehicleEmojis, symbol: "car", color: .red)
            Spacer()
            cardThemeChooser(withName: "Animals", emojis: animalEmojis, symbol: "dog", color: .brown)
            Spacer()
            cardThemeChooser(withName: "Places", emojis: buildingEmojis, symbol: "building", color: .gray)
            Spacer()
        }
    }
    
    func cardThemeChooser(withName theme: String, emojis: Array<String>, symbol: String, color: Color) -> some View {
        VStack {
            Button(action: {
                self.color = color
                self.theme = theme
                let cardCount = Int.random(in: 4..<emojis.count)
                var randomisedCards: [String] = []
                for emoji in emojis[0..<cardCount] {
                    randomisedCards.append(emoji)
                    randomisedCards.append(emoji)
                }
                self.cardCount = cardCount * 2
                self.emojis = randomisedCards.shuffled()
            }, label: {
                VStack {
                    Image(systemName: symbol)
                    Text(theme)
                        .font(.footnote)
                }
            })
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
