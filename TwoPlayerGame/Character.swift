//
//  Character.swift
//  TwoPlayerGame
//
//  Created by Nick on 2016-01-18.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import Foundation

class Character {
    
    var _player_hp: Int = 100
    var _playerAttackPower: Int = 10
    
    var player_hp: Int {
        get {
            return _player_hp
        }
    }
    
    var playerAttackPower: Int {
        get {
            return _playerAttackPower
        }
    }
    
    var isAlive: Bool {
        get {
            if _player_hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(player_hp: Int, playerAttackPower: Int)
    {
        self._player_hp = player_hp
        self._playerAttackPower = playerAttackPower
    }
    
    func didAttackPower(playerAttackPower: Int) -> Bool{
        var attack = playerAttackPower
        self._player_hp -= attack
        return true
    }
    
}
