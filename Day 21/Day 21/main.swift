//
//  main.swift
//  Day 21
//
//  Created by Peter Bohac on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

/*
 Hit Points: 100
 Damage: 8
 Armor: 2
*/

final class RPG {
    var bossHP = 100
    let bossDamage = 8
    let bossArmor = 2

    var playerHP = 100
    let playerDamage: Int
    let playerArmor: Int

    init(playerDamage: Int, playerArmor: Int) {
        self.playerDamage = playerDamage
        self.playerArmor = playerArmor
    }

    func willPlayerWin() -> Bool {
        let playerAttack = max(1, playerDamage - bossArmor)
        let bossAttack = max(1, bossDamage - playerArmor)
        while true {
            // player attacks
            bossHP -= playerAttack
            if bossHP <= 0 {
                return true
            }
            // boss attacks
            playerHP -= bossAttack
            if playerHP <= 0 {
                return false
            }
        }
    }
}

let weapons: [(cost: Int, damage: Int)] = [
    (8, 4),     // Dagger
    (10, 5),    // Shortsword
    (25, 6),    // Warhammer
    (40, 7),    // Longsword
    (74, 8),    // Greataxe
]

let armor: [(cost: Int, armor: Int)] = [
    (0, 0),     // none
    (13, 1),    // Leather
    (31, 2),    // Chainmail
    (53, 3),    // Splintmail
    (75, 4),    // Bandedmail
    (102, 5),   // Platemail
]

let rings: [(cost: Int, damage: Int, armor: Int)] = [
    (0, 0, 0),  // none
    (25, 1, 0), // Damage +1
    (50, 2, 0), // Damage +2
    (100, 3, 0),// Damage +3
    (20, 0, 1), // Defense +1
    (40, 0, 2), // Defense +2
    (80, 0, 3), // Defense +3
]

var games: [(game: RPG, cost: Int, win: Bool)] = []

for w in weapons {
    for a in armor {
        // pick 0 or 1 ring
        for r in rings {
            let cost = w.cost + a.cost + r.cost
            let game = RPG(playerDamage: w.damage + r.damage, playerArmor: a.armor + r.armor)
            let win = game.willPlayerWin()
            games.append((game, cost, win))
        }
        // pick 2 rings
        for i in 1 ..< (rings.count - 1) {
            let r1 = rings[i]
            for j in (i + 1) ..< rings.count {
                let r2 = rings[j]
                let cost = w.cost + a.cost + r1.cost + r2.cost
                let game = RPG(playerDamage: w.damage + r1.damage + r2.damage, playerArmor: a.armor + r1.armor + r2.armor)
                let win = game.willPlayerWin()
                games.append((game, cost, win))
            }
        }
    }
}

let winningGames = games.filter { $0.win }.sorted { $0.cost < $1.cost }
print("Cheapest winning game:", winningGames.first!.cost)

let losingGames = games.filter { $0.win == false }.sorted { $0.cost > $1.cost }
print("Most expensive losing game:", losingGames.first!.cost)
