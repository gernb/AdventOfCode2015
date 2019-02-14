//
//  main.swift
//  Day 18
//
//  Created by Bohac, Peter on 2/13/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Coordinate {
    let x: Int
    let y: Int

    var up: Coordinate { return Coordinate(x: x, y: y - 1) }
    var down: Coordinate { return Coordinate(x: x, y: y + 1) }
    var left: Coordinate { return Coordinate(x: x - 1, y: y) }
    var right: Coordinate { return Coordinate(x: x + 1, y: y) }
    var upLeft: Coordinate { return Coordinate(x: x - 1, y: y - 1) }
    var upRight: Coordinate { return Coordinate(x: x + 1, y: y - 1) }
    var downLeft: Coordinate { return Coordinate(x: x - 1, y: y + 1) }
    var downRight: Coordinate { return Coordinate(x: x + 1, y: y + 1) }

    var adjacent: [Coordinate] {
        return [upLeft, up, upRight, left, right, downLeft, down, downRight]
    }
}

final class Grid {
    var lights: [[Int]]

    init(initialState: String) {
        let rows = initialState.split(separator: "\n")
        self.lights = Array(repeating: Array(repeating: 0, count: rows[0].count), count: rows.count)

        for (y, row) in rows.enumerated() {
            for (x, char) in row.enumerated() {
                lights[y][x] = char == "#" ? 1 : 0
            }
        }
    }

    func draw() {
        for (_, row) in lights.enumerated() {
            for (_, light) in row.enumerated() {
                print(light == 1 ? "#" : ".", terminator: "")
            }
            print("")
        }
    }

    func animate(steps: Int, withStuckLights: Bool = false) {
        for _ in 0 ..< steps {
            if withStuckLights {
                turnOnCornerLights()
            }
            update()
            if withStuckLights {
                turnOnCornerLights()
            }
        }
    }

    func update() {
        var newLights = lights
        for y in 0 ..< lights.count {
            for x in 0 ..< lights[y].count {
                let coord = Coordinate(x: x, y: y)
                let onNeighbors = neighborLights(of: coord).reduce(0, +)
                switch self[coord] {
                case 0:
                    newLights[y][x] = onNeighbors == 3 ? 1 : 0
                case 1:
                    newLights[y][x] = (onNeighbors == 2 || onNeighbors == 3) ? 1 : 0
                default:
                    preconditionFailure()
                }
            }
        }
        lights = newLights
    }

    subscript(x: Int, y: Int) -> Int? {
        guard x >= 0 && y >= 0 && y < lights.count && x < lights[y].count else { return nil }
        return lights[y][x]
    }

    subscript(c: Coordinate) -> Int? {
        return self[c.x, c.y]
    }

    private func neighborLights(of light: Coordinate) -> [Int] {
        return light.adjacent.compactMap { self[$0] }
    }

    private func turnOnCornerLights() {
        let maxY = lights.count - 1
        let maxX = lights[maxY].count - 1
        lights[0][0] = 1
        lights[0][maxX] = 1
        lights[maxY][0] = 1
        lights[maxY][maxX] = 1
    }
}

let grid = Grid(initialState: InputData.challenge)
//grid.draw()
//
//while true {
//    grid.update()
//    print("")
//    grid.draw()
//    _ = readLine()
//}

grid.animate(steps: 100)
let on = grid.lights.flatMap { $0 }.reduce(0, +)

print("Count of lights on:", on)

// MARK: Part 2

let grid2 = Grid(initialState: InputData.challenge)
grid2.animate(steps: 100, withStuckLights: true)
let on2 = grid2.lights.flatMap { $0 }.reduce(0, +)

print("Count of lights on:", on2)
