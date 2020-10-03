//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 10/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        VStack(alignment: .leading) {
            Text("Score: \(viewModel.score)")
                .font(Font.title)
                .foregroundColor(Color.primary)
            
            Text("Theme: \(viewModel.themeName)")
                .font(Font.subheadline)
                .foregroundColor(Color.primary)
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            
            Button("New Game") {
                viewModel.newGame()
            }
            .foregroundColor(Color.primary)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary, lineWidth: 3)
            )
        }
        .padding()
        .foregroundColor(viewModel.themeColor)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius = CGFloat(10.0)
    private let edgeLineWidth = CGFloat(3)
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
