//
//  main.swift
//  Day 11
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

extension String {
    static let alphabet = Array("abcdefghijklmnopqrstuvwxyz")

    var numberArray: [Int] {
        return self.map { String.alphabet.index(of: $0)! }
    }
}

extension Array where Element == Int {
    var password: String {
        let chars = self.map { String.alphabet[$0] }
        return String(chars)
    }

    var isValidPassword: Bool {
        return hasIncreasingSequence && !hasBannedLetter && hasPairs
    }

    var hasIncreasingSequence: Bool {
        for (i, letter) in self.dropLast(2).enumerated() {
            if self[i + 1] == (letter + 1) && self[i + 2] == (letter + 2) {
                return true
            }
        }
        return false
    }

    var hasBannedLetter: Bool {
        return self.contains(String.alphabet.index(of: "i")!) ||
            self.contains(String.alphabet.index(of: "o")!) ||
            self.contains(String.alphabet.index(of: "l")!)
    }

    var hasPairs: Bool {
        var lastPair: Int?
        for (i, letter) in self.dropLast().enumerated() {
            if letter == self[i + 1] && letter != lastPair {
                if lastPair == nil {
                    lastPair = letter
                } else {
                    // found a second (different) pair
                    return true
                }
            }
        }
        return false
    }

    mutating func increment() {
        var index = self.count - 1
        while index >= 0 {
            self[index] += 1
            if self[index] >= String.alphabet.count {
                self[index] = 0
                index -= 1
            } else {
                break
            }
        }
        // skip arrays that contain 'i', 'o', and 'l'
        for letter in [String.alphabet.index(of: "i")!, String.alphabet.index(of: "o")!, String.alphabet.index(of: "l")!] {
            if let index = self.firstIndex(of: letter) {
                self[index] += 1
                for i in (index + 1) ..< self.count {
                    self[i] = 0
                }
                break
            }
        }
    }
}

// find next valid password
let password = "hxbxwxba"
var pwAsNumbers = password.numberArray
while pwAsNumbers.isValidPassword == false {
    pwAsNumbers.increment()
}
print("Next password is:", pwAsNumbers.password)

pwAsNumbers.increment()
while pwAsNumbers.isValidPassword == false {
    pwAsNumbers.increment()
}
print("Next password is:", pwAsNumbers.password)
