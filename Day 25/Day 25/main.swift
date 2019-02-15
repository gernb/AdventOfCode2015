//
//  main.swift
//  Day 25
//
//  Created by Bohac, Peter on 2/15/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

// To continue, please consult the code grid in the manual.  Enter the code at row 2947, column 3029.

var x = 1
var y = 1

var maxY = 1
var previousValue = 20151125

repeat {
    if y == 1 {
        maxY += 1
        y = maxY
        x = 1
    } else {
        y -= 1
        x += 1
    }
    let value = (previousValue * 252533) % 33554393
    previousValue = value
} while !(x == 3029 && y == 2947)

print("Code is:", previousValue)
