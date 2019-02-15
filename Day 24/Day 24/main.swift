//
//  main.swift
//  Day 24
//
//  Created by Peter Bohac on 2/14/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

extension Array where Element: Equatable {
    func removing(_ elements: [Element]) -> [Element] {
        var result = self
        elements.forEach { element in
            guard let index = result.firstIndex(where: { $0 == element }) else { return }
            result.remove(at: index)
        }
        return result
    }
}

func pick(_ count: Int, from: [Int]) -> [ArraySlice<Int>] {
    return pick(count, from: ArraySlice(from))
}

func pick(_ count: Int, from: ArraySlice<Int>) -> [ArraySlice<Int>] {
    guard count > 0 else { return [] }
    guard count < from.count else { return [from] }

    if count == 1 {
        return from.map { [$0] }
    } else {
        return from.dropLast(count - 1).enumerated()
            .flatMap { i, elem in
                return pick(count - 1, from: from.dropFirst(i + 1)).map { [elem] + $0 }
            }
    }
}

func part1() {
    let packages = InputData.challenge.sorted { $0 > $1 }
    var solutions: [[Int]: ([Int], [Int])] = [:]
    var solutionFound = false

    for x in 1 ..< (packages.count - 2) {
        if solutionFound {
            break
        }
        let group1Combinations = pick(x, from: packages)
        loop: for slice in group1Combinations {
            let group1 = Array(slice)
            let g1Weight = group1.reduce(0, +)
            let remainingPackages = packages.removing(group1)
            let remainingWeight = remainingPackages.reduce(0, +)
            guard remainingWeight == (g1Weight * 2) else { continue }
            for y in 1 ..< (remainingPackages.count - 1) {
                let group2Combinations = pick(y, from: remainingPackages)
                for slice in group2Combinations {
                    let group2 = Array(slice)
                    let g2Weight = group2.reduce(0, +)
                    if g1Weight == g2Weight {
                        let group3 = remainingPackages.removing(group2)
                        let g3Weight = group3.reduce(0, +)
                        if g1Weight == g3Weight {
                            solutions[group1] = (group2, group3)
                            solutionFound = true
                            continue loop
                        }
                    }
                }
            }
        }
    }

    let part1 = solutions.keys.min { $0.reduce(1, *) < $1.reduce(1, *) }!.reduce(1, *)
    print("Part 1:", part1)
}

part1()

// MARK: Part 2

func canDistribute(_ packages: [Int], into groupCount: Int) -> Bool {
    guard groupCount > 1 else { return true }
    for x in 1 ..< (packages.count - groupCount + 1) {
        let combos = pick(x, from: packages)
        for slice in combos {
            let group = Array(slice)
            let weight = group.reduce(0, +)
            let remainingPackages = packages.removing(group)
            let remainingWeight = remainingPackages.reduce(0, +)
            guard remainingWeight == (weight * (groupCount - 1)) else { continue }
            return canDistribute(remainingPackages, into: groupCount - 1)
        }
    }

    return false
}

func part2() {
    let packages = InputData.challenge.sorted(by: >)
    var solutions = Set<[Int]>()

    for x in 1 ..< (packages.count - 3) {
        let group1Combos = pick(x, from: packages)
        for slice in group1Combos {
            let group1 = Array(slice)
            let g1Weight = group1.reduce(0, +)
            let remainingPackages = packages.removing(group1)
            let remainingWeight = remainingPackages.reduce(0, +)
            guard remainingWeight == (g1Weight * 3) else { continue }
            if canDistribute(remainingPackages, into: 3) {
                solutions.insert(group1)
                continue
            }
        }
        if solutions.count > 0 {
            break
        }
    }

    let part2 = solutions.min { $0.reduce(1, *) < $1.reduce(1, *) }!.reduce(1, *)
    print("Part 2:", part2)
}

part2()
