//
//  main.swift
//  Day 01
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

let goingUp = InputData.challenge.filter { $0 == "(" }
let goingDown = InputData.challenge.filter { $0 == ")" }

let floor = goingUp.count - goingDown.count
print("End floor:", floor)

// MARK: Part 2

var currentFloor = 0

for (index, char) in InputData.challenge.enumerated() {
    if char == "(" {
        currentFloor += 1
    } else {
        currentFloor -= 1
    }

    if currentFloor < 0 {
        print("Basement entered at:", index + 1)
        break
    }
}
