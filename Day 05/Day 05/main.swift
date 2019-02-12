//
//  main.swift
//  Day 05
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

import Foundation

extension Character {
    var isVowel: Bool {
        return self == "a" ||
            self == "e" ||
            self == "i" ||
            self == "o" ||
            self == "u"
    }
}

extension String {
    private var containsNaughtyStrings: Bool {
        return self.contains("ab") ||
            self.contains("cd") ||
            self.contains("pq") ||
            self.contains("xy")
    }

    var isNice: Bool {
        guard self.containsNaughtyStrings == false else { return false }
        var vowelCount = 0
        var doubledChar = false
        var prevChar: Character?
        for (_, char) in self.enumerated() {
            if char.isVowel {
                vowelCount += 1
            }
            if char == prevChar {
                doubledChar = true
            }
            if doubledChar && vowelCount >= 3 {
                return true
            }
            prevChar = char
        }
        return false
    }
}

var niceWords = InputData.challenge.filter { $0.isNice }

print("Nice count:", niceWords.count)

// MARK: Part 2

extension String {
    private var hasDoublePair: Bool {
        let chars = Array(self)
        for i in 0 ..< (count - 1) {
            let pair = String([chars[i], chars[i+1]])
            if self.dropFirst(i + 2).contains(pair) {
                return true
            }
        }
        return false
    }

    private var hasXyX: Bool {
        let chars = Array(self)
        for i in 0 ..< (count - 2) {
            if chars[i] == chars[i + 2] {
                return true
            }
        }
        return false
    }

    var isNice2: Bool {
        return hasDoublePair && hasXyX
    }
}

niceWords = InputData.challenge.filter { $0.isNice2 }

print("Nice count:", niceWords.count)
