//
//  main.swift
//  Day 03
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Coordinate: Hashable {
    let x: Int
    let y: Int

    static let origin = Coordinate(x: 0, y: 0)

    var up: Coordinate { return Coordinate(x: x, y: y - 1) }
    var down: Coordinate { return Coordinate(x: x, y: y + 1) }
    var left: Coordinate { return Coordinate(x: x - 1, y: y) }
    var right: Coordinate { return Coordinate(x: x + 1, y: y) }
}

var location = Coordinate.origin
var visited: [Coordinate: Int] = [location: 1]

InputData.challenge.forEach { char in
    switch char {
    case "^": location = location.up
    case "v": location = location.down
    case "<": location = location.left
    case ">": location = location.right
    default: preconditionFailure()
    }
    visited[location] = visited[location, default: 0] + 1
}

print("Visited \(visited.count) locations")

// MARK: Part 1

var locations = [Coordinate.origin, Coordinate.origin]
visited = [.origin: 2]

for (i, char) in InputData.challenge.enumerated() {
    switch char {
    case "^": locations[i % 2] = locations[i % 2].up
    case "v": locations[i % 2] = locations[i % 2].down
    case "<": locations[i % 2] = locations[i % 2].left
    case ">": locations[i % 2] = locations[i % 2].right
    default: preconditionFailure()
    }
    visited[locations[i % 2]] = visited[locations[i % 2], default: 0] + 1
}

print("Visited \(visited.count) locations")
