//
//  main.swift
//  Day 10
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

extension String {
    var lookNsay: String {
        guard isEmpty == false else { return "" }
        var result: [Character] = []
        var previousChar: Character?
        var runLength = 1

        self.forEach { char in
            if char == previousChar {
                runLength += 1
            } else if let previousChar = previousChar {
                result += Array(String(runLength)) + [previousChar]
                runLength = 1
            }
            previousChar = char
        }
        result += Array(String(runLength)) + [previousChar!]

        return String(result)
    }
}

var sequence = "1113122113"
for _ in 1 ... 40 {
    sequence = sequence.lookNsay
}

print("Part 1 solution:", sequence.count)

for _ in 1 ... 10 {
    sequence = sequence.lookNsay
}

print("Part 2 solution:", sequence.count)
