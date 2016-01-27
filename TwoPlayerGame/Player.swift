//
//  Player.swift
//  TwoPlayerGame
//
//  Created by Nick on 2016-01-18.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import Foundation

class Player: Character {
    
    var _playerName: String = "Player"
    
    var playerName: String {
        get {
            return _playerName
        }
    }
    
    convenience init(player_hp: Int, playerAttackPower: Int, playerName: String) {
        self.init(player_hp: player_hp, playerAttackPower: playerAttackPower)
        self._playerName = playerName
    }
    
}