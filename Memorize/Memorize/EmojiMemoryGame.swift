//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 11/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import SwiftUI

private struct ThemedEmojiGame: Hashable {
    let themeName: String
    let emojis: Array<String>
    let amountOfCards: AmountOfCards
    let themeColor: Color
    
    enum AmountOfCards {
        case fixed, random
    }
}

private let gameSets: Set = [
    ThemedEmojiGame(
        themeName: "Hallowen",
        emojis: ["🎃", "👻", "🦸‍♂️", "🤡"],
        amountOfCards: .fixed,
        themeColor: Color.orange
    ),
    ThemedEmojiGame(
        themeName: "New Year",
        emojis: ["⛄️", "🎄", "🎅", "🎆"],
        amountOfCards: .fixed,
        themeColor: Color.green
    ),
    ThemedEmojiGame(
        themeName: "Places",
        emojis: ["🏯", "🗼", "🗽", "⛩️", "🎡", "🎢", "🛕", "🕌", "⛪", "🏝️", "🗻", "🏦"],
        amountOfCards: .random,
        themeColor: Color.gray
    ),
    ThemedEmojiGame(
        themeName: "Flags",
        emojis: ["🇨🇦", "🇨🇳", "🇩🇪"],
        amountOfCards: .fixed,
        themeColor: Color.red
    ),
    ThemedEmojiGame(
        themeName: "Animals",
        emojis: ["🐶", "🦊", "🐱", "🦁", "🐯", "🦄", "🐮", "🐷", "🐭", "🐹", "🐼", "🐨"],
        amountOfCards: .random,
        themeColor: Color.yellow
    ),
    ThemedEmojiGame(
        themeName: "Food",
        emojis: ["🥥", "🥑", "🧀", "🍕"],
        amountOfCards: .fixed,
        themeColor: Color.green
    ),
]

class EmojiMemoryGame: ObservableObject {
    private var chosenGameConfig: ThemedEmojiGame
    @Published private var model: MemoryGame<String>
    
    init() {
        let (chosenGameConfig, model) = EmojiMemoryGame.generateNewGame()
        
        self.chosenGameConfig = chosenGameConfig
        self.model = model
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        chosenGameConfig.themeColor
    }
    
    var themeName: String {
        chosenGameConfig.themeName
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        let (chosenGameConfig, model) = EmojiMemoryGame.generateNewGame()
        
        self.chosenGameConfig = chosenGameConfig
        self.model = model
    }
    
    // TODO: - Move generation to the additional factories/providers
    private static func generateNewGame() -> (ThemedEmojiGame, MemoryGame<String>) {
        let randomGameConfig = gameSets.randomElement()!
        
        let gameEmojis: Array<String>
        let numberOfPairOfCards: Int
        
        switch randomGameConfig.amountOfCards {
        case .fixed:
            gameEmojis = randomGameConfig.emojis
            numberOfPairOfCards = gameEmojis.count
        case .random:
            gameEmojis = Array(randomGameConfig.emojis.shuffled())
            numberOfPairOfCards = Int.random(in: 2..<min(gameEmojis.count, 5))
        }
        
        let memoryGame = MemoryGame<String>(numberOfPairOfCards: numberOfPairOfCards) { pairIndex in
            return gameEmojis[pairIndex]
        }
        
        return (randomGameConfig, memoryGame)
    }
}
