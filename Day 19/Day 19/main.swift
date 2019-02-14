//
//  main.swift
//  Day 19
//
//  Created by Bohac, Peter on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> [Range<String.Index>] {
        let range = NSRange(string.startIndex..., in: string)
        return matches(in: string, range: range).map { result in
            return Range(result.range, in: string)!
        }
    }
}

extension String {
    private static let atomRegex = try! NSRegularExpression(pattern: "e|[A-Z][a-z]?")
    var atoms: [String] {
        return String.atomRegex.matches(self).map { String(self[$0]) }
    }
}

func loadRules(from input: String) -> [String: [String]] {
    var rules: [String: [String]] = [:]
    input.split(separator: "\n")
        .map { $0.split(separator: " ").map(String.init) }
        .forEach { words in
            rules[words[0]] = rules[words[0], default: []] + [ words[2] ]
        }
    return rules
}

func generateNewMolecules(from molecule: String, using rules: [String: [String]]) -> Set<String> {
    var result = Set<String>()
    let atoms = molecule.atoms

    for (i, atom) in atoms.enumerated() {
        guard let replacements = rules[atom] else { continue }
        replacements.forEach { newAtom in
            var newMolecule = atoms
            newMolecule[i] = newAtom
            result.insert(newMolecule.joined())
        }
    }

    return result
}

let rules = loadRules(from: InputData.Challenge.rules)
let newMolecules = generateNewMolecules(from: InputData.Challenge.molecule, using: rules)

print("Distinct new molecules:", newMolecules.count)

// MARK: Part 2

let atoms = InputData.Challenge.molecule.atoms
let rnCount = atoms.filter { $0 == "Rn" }.count
let arCount = atoms.filter { $0 == "Ar" }.count
let yCount = atoms.filter { $0 == "Y" }.count

let steps = atoms.count - rnCount - arCount - 2*yCount - 1
print("Steps:", steps)
