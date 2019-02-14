//
//  main.swift
//  Day 20
//
//  Created by Peter Bohac on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

let challenge = 36_000_000

var houses = Array(repeating: 10, count: 1_000_000)

for houseNum in 2 ..< houses.count {
    for j in stride(from: houseNum, to: houses.count, by: houseNum) {
        houses[j] += houseNum * 10
    }
    if houses[houseNum] >= challenge {
        print("House #\(houseNum) has \(houses[houseNum]) presents.")
        break
    }
}

// MARK: Part 2

houses = Array(repeating: 0, count: 1_000_000)

for houseNum in 1 ..< houses.count {
    for j in 1 ... 50 {
        let index = j * houseNum
        guard index < houses.count else { continue }
        houses[index] += houseNum * 11
    }
    if houses[houseNum] >= challenge {
        print("House #\(houseNum) has \(houses[houseNum]) presents.")
        break
    }
}
