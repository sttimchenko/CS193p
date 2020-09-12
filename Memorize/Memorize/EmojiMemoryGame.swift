//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 11/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import Foundation

private let emojis = ["👻", "🎃", "🦸‍♂️", "🐵", "💩", "😇", "🤬", "🤡", "😻", "🤦‍♂️", "🐙", "🥑", "🔥", "🥳", "🤪", "🧐"]

class EmojiMemoryGame {
    private let model = EmojiMemoryGame.createMemoryGame()
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let numberOfPairsOfCards = Int.random(in: 2...5)
        
        var emojisSubset = Set<String>()
        
        while emojisSubset.count < numberOfPairsOfCards {
            emojisSubset.insert(emojis.randomElement()!)
        }
        
        let gameEmojis = Array(emojisSubset)
        
        return MemoryGame<String>(numberOfPairOfCards: numberOfPairsOfCards) { pairIndex in
            return gameEmojis[pairIndex]
        }
    }
}
