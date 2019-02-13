//
//  main.swift
//  Day 08
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

import Foundation

func load(from filename: String) -> [String] {
    let pwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let inputFileUrl = pwd.appendingPathComponent(filename)
    let input = try! String(contentsOf: inputFileUrl)
    let lines = input.split(separator: "\n").map(String.init)
    return lines
}

extension String {
    private enum ProcessingState: Equatable {
        case normal, escape, hexEscape0, hexEscape1
    }

    var characterCount: Int {
        var result = 0
        var chars = ArraySlice(self)
        if chars.first == "\"" {
            chars = chars.dropFirst()
        }
        if chars.last == "\"" {
            chars = chars.dropLast()
        }
        var state = ProcessingState.normal

        for (_, char) in chars.enumerated() {
            switch (char, state) {
            case ("\\", .normal):
                state = .escape
            case (_, .normal):
                result += 1
            case ("x", .escape):
                state = .hexEscape0
            case (_, .escape):
                result += 1
                state = .normal
            case (_, .hexEscape0):
                state = .hexEscape1
            case (_, .hexEscape1):
                result += 1
                state = .normal
            }
        }

        assert(state == .normal)
        return result
    }
}

let list = load(from: "challenge.txt")
let counts = list.map { ($0.count, $0.characterCount) }
    .reduce((literalsCount: 0, charactersCount: 0)) { ($0.literalsCount + $1.0, $0.charactersCount + $1.1) }
print("Part 1 solution:", counts.literalsCount - counts.charactersCount)

// MARK: Part 2

extension String {
    var encoded: String {
        var result: [Character] = []

        self.forEach { char in
            switch char {
            case "\"": result += ["\\", "\""]
            case "\\": result += ["\\", "\\"]
            default: result.append(char)
            }
        }
        return "\"" + String(result) + "\""
    }
}

let counts2 = list.map { ($0.count, $0.encoded.count) }
    .reduce((literalsCount: 0, charactersCount: 0)) { ($0.literalsCount + $1.0, $0.charactersCount + $1.1) }
print("Part 2 solution:", counts2.charactersCount - counts2.literalsCount)
