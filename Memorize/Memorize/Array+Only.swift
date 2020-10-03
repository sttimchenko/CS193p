//
//  Array+Only.swift
//  Memorize
//
//  Created by Stanislav Timchenko on 20/9/20.
//  Copyright © 2020 Stanislav Timchenko. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
