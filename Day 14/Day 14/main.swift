//
//  main.swift
//  Day 14
//
//  Created by Peter Bohac on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Reindeer: Hashable {
    let name: String
    let speed: Int
    let flyingTime: Int
    let restingTime: Int
}

extension Reindeer {
    private init(string: Substring) {
        let words = string.split(separator: " ").map(String.init)
        self.name = words[0]
        self.speed = Int(words[3])!
        self.flyingTime = Int(words[6])!
        self.restingTime = Int(words[13])!
    }

    static func load(from input: String) -> [Reindeer] {
        return input.split(separator: "\n").map(Reindeer.init)
    }
}

extension Reindeer {
    func distance(at time: Int) -> Int {
        let fullCycles = time / (flyingTime + restingTime)
        let remainderTime = time % (flyingTime + restingTime)
        let remainderDistance = min(flyingTime, remainderTime) * speed
        return (fullCycles * speed * flyingTime) + remainderDistance
    }
}

let reindeer = Reindeer.load(from: InputData.challenge)
let distances = reindeer.map { $0.distance(at: 2503) }

print("Winning distance:", distances.max()!)

// MARK: Part 2

var scores: [Reindeer: Int] = [:]
for time in 1 ... 2503 {
    let distances = reindeer.map { (reindeer: $0, distance: $0.distance(at: time)) }
        .sorted { $0.distance > $1.distance }
    let maxDistance = distances.first!.distance
    distances.filter { $0.distance == maxDistance }.forEach { leader in
        scores[leader.reindeer] = scores[leader.reindeer, default: 0] + 1
    }
}

print("Winning score:", scores.values.max()!)
