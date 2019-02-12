//
//  main.swift
//  Day 06
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

/*
 turn on 0,0 through 999,999
 toggle 0,0 through 999,0
 turn off 499,499 through 500,500
 */
typealias Pair = (x: Int, y: Int)

enum Instruction {
    case turnOn(left: Pair, right: Pair)
    case turnOff(left: Pair, right: Pair)
    case toggle(left: Pair, right: Pair)
}

extension Instruction {
    private init(string: Substring) {
        let words = string.split(separator: " ")
        switch (words[0], words[1]) {
        case ("turn", "on"):
            let left = words[2].split(separator: ",").map { Int(String($0))! }
            let right = words[4].split(separator: ",").map { Int(String($0))! }
            self = .turnOn(left: (left[0], left[1]), right: (right[0], right[1]))
        case ("turn", "off"):
            let left = words[2].split(separator: ",").map { Int(String($0))! }
            let right = words[4].split(separator: ",").map { Int(String($0))! }
            self = .turnOff(left: (left[0], left[1]), right: (right[0], right[1]))
        case ("toggle", _):
            let left = words[1].split(separator: ",").map { Int(String($0))! }
            let right = words[3].split(separator: ",").map { Int(String($0))! }
            self = .toggle(left: (left[0], left[1]), right: (right[0], right[1]))
        default:
            preconditionFailure()
        }
    }

    static func load(from input: String) -> [Instruction] {
        return input.split(separator: "\n").map(Instruction.init)
    }
}

extension Instruction {
    func execute(with lights: inout [[Int]]) {
        switch self {
        case .turnOn(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] = 1
                }
            }
        case .turnOff(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] = 0
                }
            }
        case .toggle(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] = lights[y][x] == 1 ? 0 : 1
                }
            }
        }
    }
}

let instructions = Instruction.load(from: InputData.challenge)
var lights = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

instructions.forEach { $0.execute(with: &lights) }
let countOn = lights.flatMap { $0 }.reduce(0, +)
print("Lights that are on:", countOn)

// MARK: Part 2

extension Instruction {
    func execute2(with lights: inout [[Int]]) {
        switch self {
        case .turnOn(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] += 1
                }
            }
        case .turnOff(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] = max(0, lights[y][x] - 1)
                }
            }
        case .toggle(let left, let right):
            for y in left.y ... right.y {
                for x in left.x ... right.x {
                    lights[y][x] += 2
                }
            }
        }
    }
}

lights = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

instructions.forEach { $0.execute2(with: &lights) }
let totalBrightness = lights.flatMap { $0 }.reduce(0, +)
print("Total brightness:", totalBrightness)
