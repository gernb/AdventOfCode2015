//
//  main.swift
//  Day 16
//
//  Created by Peter Bohac on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct AuntSue {
    let id: Int

    let children: Int?
    let cats: Int?
    let samoyeds: Int?
    let pomeranians: Int?
    let akitas: Int?
    let vizslas: Int?
    let goldfish: Int?
    let trees: Int?
    let cars: Int?
    let perfumes: Int?
}

extension AuntSue {
    private init(string: Substring) {
        let words = string.split(separator: " ")
        self.id = Int(String(words[1].dropLast()))!

        if let index = words.firstIndex(of: "children:") {
            self.children = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.children = nil
        }

        if let index = words.firstIndex(of: "cats:") {
            self.cats = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.cats = nil
        }

        if let index = words.firstIndex(of: "samoyeds:") {
            self.samoyeds = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.samoyeds = nil
        }

        if let index = words.firstIndex(of: "pomeranians:") {
            self.pomeranians = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.pomeranians = nil
        }

        if let index = words.firstIndex(of: "akitas:") {
            self.akitas = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.akitas = nil
        }

        if let index = words.firstIndex(of: "vizslas:") {
            self.vizslas = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.vizslas = nil
        }

        if let index = words.firstIndex(of: "goldfish:") {
            self.goldfish = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.goldfish = nil
        }

        if let index = words.firstIndex(of: "trees:") {
            self.trees = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.trees = nil
        }

        if let index = words.firstIndex(of: "cars:") {
            self.cars = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.cars = nil
        }

        if let index = words.firstIndex(of: "perfumes:") {
            self.perfumes = Int(words[index + 1].hasSuffix(",") ? String(words[index + 1].dropLast()) : String(words[index + 1]))!
        } else {
            self.perfumes = nil
        }
    }

    static func load(from input: String) -> [AuntSue] {
        return input.split(separator: "\n").map(AuntSue.init)
    }
}

extension AuntSue {
    static func == (lhs: AuntSue, rhs: AuntSue) -> Bool {
        if let children = rhs.children, lhs.children! != children {
            return false
        }
        if let cats = rhs.cats, lhs.cats! != cats {
            return false
        }
        if let samoyeds = rhs.samoyeds, lhs.samoyeds! != samoyeds {
            return false
        }
        if let pomeranians = rhs.pomeranians, lhs.pomeranians! != pomeranians {
            return false
        }
        if let akitas = rhs.akitas, lhs.akitas! != akitas {
            return false
        }
        if let vizslas = rhs.vizslas, lhs.vizslas! != vizslas {
            return false
        }
        if let goldfish = rhs.goldfish, lhs.goldfish! != goldfish {
            return false
        }
        if let trees = rhs.trees, lhs.trees! != trees {
            return false
        }
        if let cars = rhs.cars, lhs.cars! != cars {
            return false
        }
        if let perfumes = rhs.perfumes, lhs.perfumes! != perfumes {
            return false
        }
        return true
    }
}

let auntToMatch = AuntSue(id: 0,
                          children: 3,
                          cats: 7,
                          samoyeds: 2,
                          pomeranians: 3,
                          akitas: 0,
                          vizslas: 0,
                          goldfish: 5,
                          trees: 3,
                          cars: 2,
                          perfumes: 1)

let aunts = AuntSue.load(from: InputData.challenge)

aunts.forEach { aunt in
    if auntToMatch == aunt {
        print("Aunt \(aunt.id) matches.")
    }
}

print("")

// MARK: Part 2

extension AuntSue {
    func reallyEquals(other: AuntSue) -> Bool {
        if let children = other.children, self.children! != children {
            return false
        }
        if let cats = other.cats, cats <= self.cats! {
            return false
        }
        if let samoyeds = other.samoyeds, self.samoyeds! != samoyeds {
            return false
        }
        if let pomeranians = other.pomeranians, pomeranians >= self.pomeranians! {
            return false
        }
        if let akitas = other.akitas, self.akitas! != akitas {
            return false
        }
        if let vizslas = other.vizslas, self.vizslas! != vizslas {
            return false
        }
        if let goldfish = other.goldfish, goldfish >= self.goldfish! {
            return false
        }
        if let trees = other.trees, trees <= self.trees! {
            return false
        }
        if let cars = other.cars, self.cars! != cars {
            return false
        }
        if let perfumes = other.perfumes, self.perfumes! != perfumes {
            return false
        }
        return true
    }
}

aunts.forEach { aunt in
    if auntToMatch.reallyEquals(other: aunt) {
        print("Aunt \(aunt.id) matches.")
    }
}
