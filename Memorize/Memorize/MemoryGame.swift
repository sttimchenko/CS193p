//
//  MemoryGame.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 11/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score: Int
    
    var indexOfFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private var seenCardsIndexes: Array<Int>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        score = 0
        seenCardsIndexes = []
        
        for pairIndex in 0..<numberOfPairOfCards {
            let content = cardContentFactory(pairIndex)
             
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        print("Card chosed: \(card)")
        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                let didMatch = cards[chosenIndex].content == cards[potentialMatchIndex].content
                
                if didMatch {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    seenCardsIndexes.removeAll { i in
                        i == chosenIndex || i == potentialMatchIndex
                    }
                }
                
                cards[chosenIndex].isFaceUp = true
                
                calculateScore(firstIndex: chosenIndex, secondIndex: potentialMatchIndex, isMatch: didMatch)
                
                seenCardsIndexes.append(chosenIndex)
                seenCardsIndexes.append(potentialMatchIndex)
            } else {
                indexOfFaceUpCard = chosenIndex
            }
        }
        
        print("Seen cards indexes: \(seenCardsIndexes)")
        print("Current score: \(score)")
    }
    
    private mutating func calculateScore(firstIndex: Int, secondIndex: Int, isMatch: Bool) {
        if isMatch {
            score += 2
        } else {
            score -= seenCardsIndexes.contains(firstIndex) ? 1 : 0
            score -= seenCardsIndexes.contains(secondIndex) ? 1 : 0
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
