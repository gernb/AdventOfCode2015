//
//  main.swift
//  Day 13
//
//  Created by Peter Bohac on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Pair: Hashable {
    let name1: String
    let name2: String

    init(name1: String, name2: String) {
        if name1 < name2 {
            self.name1 = name1
            self.name2 = name2
        } else {
            self.name1 = name2
            self.name2 = name1
        }
    }
}

extension Array where Element: Equatable {
    var permutations: [[Element]] {
        guard self.count > 1 else { return [self] }
        return self.flatMap { element in
            return self.removing(element).permutations.map { [element] + $0 }
        }
    }

    func removing(_ element: Element) -> [Element] {
        guard let index = firstIndex(where: { $0 == element }) else { return self }
        var result = self
        result.remove(at: index)
        return result
    }
}

func loadRules(from input: String) -> (rules: [Pair: Int], people: [String]) {
    var rules: [Pair: Int] = [:]
    var people = Set<String>()

    input.split(separator: "\n").forEach { line in
        let words = line.split(separator: " ").map(String.init)
        let name1 = words[0]
        let name2 = String(words.last!.dropLast())
        var value = Int(words[3])!
        if words[2] == "lose" {
            value = -value
        }
        let pair = Pair(name1: name1, name2: name2)
        rules[pair] = rules[pair, default: 0] + value
        people.insert(name1)
        people.insert(name2)
    }

    return (rules, people.sorted())
}

var (rules, people) = loadRules(from: InputData.challenge)

let arrangements = people.permutations.map { arrangement -> (solution: [String], happiness: Int) in
    let pairs = arrangement.enumerated().map { i, person in
        return Pair(name1: person, name2: arrangement[(i + 1) % arrangement.count])
    }
    let happiness = pairs.reduce(0) { $0 + rules[$1]! }
    return (arrangement, happiness)
}.sorted { $0.happiness < $1.happiness }

print("Total happiness change is:", arrangements.last!.happiness)

// MARK: Part 2

people.forEach { person in
    let pair = Pair(name1: person, name2: "Me")
    rules[pair] = 0
}
people += ["Me"]

let arrangements2 = people.permutations.map { arrangement -> (solution: [String], happiness: Int) in
    let pairs = arrangement.enumerated().map { i, person in
        return Pair(name1: person, name2: arrangement[(i + 1) % arrangement.count])
    }
    let happiness = pairs.reduce(0) { $0 + rules[$1]! }
    return (arrangement, happiness)
}.sorted { $0.happiness < $1.happiness }

print("Total happiness with me is:", arrangements2.last!.happiness)
