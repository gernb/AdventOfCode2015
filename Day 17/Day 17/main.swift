//
//  main.swift
//  Day 17
//
//  Created by Bohac, Peter on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Container: Hashable {
    let id: Int
    let size: Int
}

func find(containers: [Container], toHold litres: Int) -> Set<Set<Container>> {
    var result = Set<Set<Container>>()
    let filtered = containers.filter { $0.size <= litres }

    for (i, bottle) in filtered.enumerated() {
        if bottle.size == litres {
            result.insert(Set([bottle]))
        } else {
            let subContainers = filtered.dropFirst(i + 1)
            let partials = find(containers: Array(subContainers), toHold: litres - bottle.size)
            partials.forEach { partial in
                var newSet = partial
                newSet.insert(bottle)
                result.insert(newSet)
            }
        }
    }

    return result
}

let containers = InputData.challenge
    .split(separator: "\n")
    .enumerated()
    .map { i, size in Container(id: i, size: Int(String(size))!) }
    .sorted { $0.size > $1.size }

let combinations = find(containers: containers, toHold: 150)
print("Total combinations:", combinations.count)

// MARK: Part 2

let minContainers = combinations.min { $0.count < $1.count }!
let minCount = combinations.filter { $0.count == minContainers.count }
print("Minimum containers is: \(minContainers.count). There are \(minCount.count) such combinations.")
