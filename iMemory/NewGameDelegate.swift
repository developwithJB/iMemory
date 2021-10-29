//
//  NewGameDelegate.swift
//  iMemory
//
//  Created by Justin Bergeron on 10/15/18.
//  Copyright © 2018 Justin Bergeron. All rights reserved.
//

import Foundation

protocol NewGameDelegate {
    func newGameRequirements(difficulty: String, restart: Bool)
}
