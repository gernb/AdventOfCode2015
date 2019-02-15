//
//  main.swift
//  Day 22
//
//  Created by Peter Bohac on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

/*
 Hit Points: 58
 Damage: 9
*/

struct State: Hashable {
    let bossHP: Int
    let bossDamage: Int

    let playerHP: Int
    let playerMana: Int

    let shieldTimer: Int
    let poisonTimer: Int
    let rechargeTimer: Int

    let hardMode: Bool

    static let example1 = State(bossHP: 13, bossDamage: 8, playerHP: 10, playerMana: 250, shieldTimer: 0, poisonTimer: 0, rechargeTimer: 0, hardMode: false)
    static let example2 = State(bossHP: 14, bossDamage: 8, playerHP: 10, playerMana: 250, shieldTimer: 0, poisonTimer: 0, rechargeTimer: 0, hardMode: false)
    static let challenge = State(bossHP: 58, bossDamage: 9, playerHP: 50, playerMana: 500, shieldTimer: 0, poisonTimer: 0, rechargeTimer: 0, hardMode: false)
    static let challenge2 = State(bossHP: 58, bossDamage: 9, playerHP: 50, playerMana: 500, shieldTimer: 0, poisonTimer: 0, rechargeTimer: 0, hardMode: true)

    var playerWon: Bool {
        return playerHP > 0 && bossHP <= 0
    }

    var bossWon: Bool {
        return playerHP <= 0 && bossHP > 0
    }

    var gameOver: Bool {
        return playerWon || bossWon
    }

    var moves: [(spell: String, state: State, cost: Int)] {
        var result: [(spell: String, state: State, cost: Int)] = []
        guard !gameOver else { return result }

        if hardMode && (self.playerHP - 1) <= 0 {
            // Player loses
            return result
        }

        var playerMana = self.rechargeTimer > 0 ? self.playerMana + 101 : self.playerMana
        var playerHP = hardMode ? self.playerHP - 1 : self.playerHP

        if playerMana >= 53 {
            // Player's turn
            var bossHP = self.poisonTimer > 0 ? self.bossHP - 3 : self.bossHP
            var playerArmor = self.shieldTimer > 0 ? 7 : 0

            var shieldTimer = max(0, self.shieldTimer - 1)
            var poisonTimer = max(0, self.poisonTimer - 1)
            var rechargeTimer = max(0, self.rechargeTimer - 1)

            // Cast a Magic Missile
            bossHP -= 4
            playerMana -= 53

            // Boss's turn
            bossHP -= poisonTimer > 0 ? 3 : 0
            playerArmor = shieldTimer > 0 ? 7 : 0
            playerMana += rechargeTimer > 0 ? 101 : 0
            shieldTimer = max(0, shieldTimer - 1)
            poisonTimer = max(0, poisonTimer - 1)
            rechargeTimer = max(0, rechargeTimer - 1)

            if bossHP > 0 {
                playerHP -= max(1, bossDamage - playerArmor)
            }
            let newState = State(bossHP: bossHP, bossDamage: bossDamage, playerHP: playerHP, playerMana: playerMana, shieldTimer: shieldTimer, poisonTimer: poisonTimer, rechargeTimer: rechargeTimer, hardMode: hardMode)
            result.append(("Missile", newState, 53))
        }

        playerMana = self.rechargeTimer > 0 ? self.playerMana + 101 : self.playerMana
        playerHP = hardMode ? self.playerHP - 1 : self.playerHP

        if playerMana >= 73 {
            // Player's turn
            var bossHP = self.poisonTimer > 0 ? self.bossHP - 3 : self.bossHP
            var playerArmor = self.shieldTimer > 0 ? 7 : 0

            var shieldTimer = max(0, self.shieldTimer - 1)
            var poisonTimer = max(0, self.poisonTimer - 1)
            var rechargeTimer = max(0, self.rechargeTimer - 1)

            // Cast a Drain spell
            bossHP -= 2
            playerHP += 2
            playerMana -= 73

            // Boss's turn
            bossHP -= poisonTimer > 0 ? 3 : 0
            playerArmor = shieldTimer > 0 ? 7 : 0
            playerMana += rechargeTimer > 0 ? 101 : 0
            shieldTimer = max(0, shieldTimer - 1)
            poisonTimer = max(0, poisonTimer - 1)
            rechargeTimer = max(0, rechargeTimer - 1)

            if bossHP > 0 {
                playerHP -= max(1, bossDamage - playerArmor)
            }
            let newState = State(bossHP: bossHP, bossDamage: bossDamage, playerHP: playerHP, playerMana: playerMana, shieldTimer: shieldTimer, poisonTimer: poisonTimer, rechargeTimer: rechargeTimer, hardMode: hardMode)
            result.append(("Drain", newState, 73))
        }

        playerMana = self.rechargeTimer > 0 ? self.playerMana + 101 : self.playerMana
        playerHP = hardMode ? self.playerHP - 1 : self.playerHP

        if playerMana >= 113 && shieldTimer <= 1 {
            // Player's turn
            var bossHP = self.poisonTimer > 0 ? self.bossHP - 3 : self.bossHP
            var playerArmor = self.shieldTimer > 0 ? 7 : 0

            var shieldTimer = max(0, self.shieldTimer - 1)
            var poisonTimer = max(0, self.poisonTimer - 1)
            var rechargeTimer = max(0, self.rechargeTimer - 1)

            // Cast a Shield spell
            shieldTimer = 6
            playerMana -= 113

            // Boss's turn
            bossHP -= poisonTimer > 0 ? 3 : 0
            playerArmor = shieldTimer > 0 ? 7 : 0
            playerMana += rechargeTimer > 0 ? 101 : 0
            shieldTimer = max(0, shieldTimer - 1)
            poisonTimer = max(0, poisonTimer - 1)
            rechargeTimer = max(0, rechargeTimer - 1)

            if bossHP > 0 {
                playerHP -= max(1, bossDamage - playerArmor)
            }
            let newState = State(bossHP: bossHP, bossDamage: bossDamage, playerHP: playerHP, playerMana: playerMana, shieldTimer: shieldTimer, poisonTimer: poisonTimer, rechargeTimer: rechargeTimer, hardMode: hardMode)
            result.append(("Shield", newState, 113))
        }

        playerMana = self.rechargeTimer > 0 ? self.playerMana + 101 : self.playerMana
        playerHP = hardMode ? self.playerHP - 1 : self.playerHP

        if playerMana >= 173 && poisonTimer <= 1 {
            // Player's turn
            var bossHP = self.poisonTimer > 0 ? self.bossHP - 3 : self.bossHP
            var playerArmor = self.shieldTimer > 0 ? 7 : 0

            var shieldTimer = max(0, self.shieldTimer - 1)
            var poisonTimer = max(0, self.poisonTimer - 1)
            var rechargeTimer = max(0, self.rechargeTimer - 1)

            // Cast a Poison spell
            poisonTimer = 6
            playerMana -= 173

            // Boss's turn
            bossHP -= poisonTimer > 0 ? 3 : 0
            playerArmor = shieldTimer > 0 ? 7 : 0
            playerMana += rechargeTimer > 0 ? 101 : 0
            shieldTimer = max(0, shieldTimer - 1)
            poisonTimer = max(0, poisonTimer - 1)
            rechargeTimer = max(0, rechargeTimer - 1)

            if bossHP > 0 {
                playerHP -= max(1, bossDamage - playerArmor)
            }
            let newState = State(bossHP: bossHP, bossDamage: bossDamage, playerHP: playerHP, playerMana: playerMana, shieldTimer: shieldTimer, poisonTimer: poisonTimer, rechargeTimer: rechargeTimer, hardMode: hardMode)
            result.append(("Poison", newState, 173))
        }

        playerMana = self.rechargeTimer > 0 ? self.playerMana + 101 : self.playerMana
        playerHP = hardMode ? self.playerHP - 1 : self.playerHP

        if playerMana >= 229 && rechargeTimer <= 1 {
            // Player's turn
            var bossHP = self.poisonTimer > 0 ? self.bossHP - 3 : self.bossHP
            var playerArmor = self.shieldTimer > 0 ? 7 : 0

            var shieldTimer = max(0, self.shieldTimer - 1)
            var poisonTimer = max(0, self.poisonTimer - 1)
            var rechargeTimer = max(0, self.rechargeTimer - 1)

            // Cast a Recharge spell
            rechargeTimer = 5
            playerMana -= 229

            // Boss's turn
            bossHP -= poisonTimer > 0 ? 3 : 0
            playerArmor = shieldTimer > 0 ? 7 : 0
            playerMana += rechargeTimer > 0 ? 101 : 0
            shieldTimer = max(0, shieldTimer - 1)
            poisonTimer = max(0, poisonTimer - 1)
            rechargeTimer = max(0, rechargeTimer - 1)

            if bossHP > 0 {
                playerHP -= max(1, bossDamage - playerArmor)
            }
            let newState = State(bossHP: bossHP, bossDamage: bossDamage, playerHP: playerHP, playerMana: playerMana, shieldTimer: shieldTimer, poisonTimer: poisonTimer, rechargeTimer: rechargeTimer, hardMode: hardMode)
            result.append(("Recharge", newState, 229))
        }

        return result
    }
}

func findCheapestWin(start: State) -> (moves: [(State, String)], mana: Int) {
    var seen: [State: Int] = [:]
    var queue: [State: (moves: [(State, String)], mana: Int)] = [start: ([], 0)]

    while let (state, (moves, mana)) = queue.min(by: { $0.value.mana < $1.value.mana }) {
        queue.removeValue(forKey: state)
        if state.gameOver {
            if state.playerWon {
                return (moves, mana)
            } else {
                continue
            }
        }

        state.moves.forEach { move, nextState, cost in
            let newCost = mana + cost
            if let previousCost = seen[nextState], previousCost <= newCost {
                return
            }
            if let queued = queue[nextState], queued.mana <= newCost {
                return
            }

            queue[nextState] = (moves + [(nextState, move)], newCost)
        }

        seen[state] = mana
    }

    preconditionFailure("Player cannot win!")
}

let (moves, totalManaCost) = findCheapestWin(start: State.challenge)
print("Minimum mana cost to win is:", totalManaCost)

let (moves2, totalManaCost2) = findCheapestWin(start: State.challenge2)
print("Minimum mana cost to win with hard mode is:", totalManaCost2)
