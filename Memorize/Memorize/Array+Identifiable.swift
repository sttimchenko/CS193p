//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 20/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for (index, candidate) in self.enumerated() {
            if matching.id == candidate.id {
                return index
            }
        }
        
        return nil
    }
}
