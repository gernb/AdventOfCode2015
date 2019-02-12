//
//  main.swift
//  Day 02
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Package {
    let l: Int
    let w: Int
    let h: Int

    var area: Int {
        return 2 * l * w + 2 * w * h + 2 * h * l
    }

    var areaSmallestSide: Int {
        let sides = [l, w, h].sorted()
        return sides[0] * sides[1]
    }

    var totalArea: Int {
        return area + areaSmallestSide
    }
}

extension Package {
    private init(string: Substring) {
        let values = string.split(separator: "x").map { Int(String($0))! }
        self.l = values[0]
        self.w = values[1]
        self.h = values[2]
    }

    static func load(from input: String) -> [Package] {
        return input.split(separator: "\n").map(Package.init)
    }
}

let packages = Package.load(from: InputData.challenge)
let totalArea = packages.reduce(0) { $0 + $1.totalArea }

print("Total square feet needed:", totalArea)

// MARK: Part 2

extension Package {
    var volume: Int {
        return l * w * h
    }

    var smallestPerimeter: Int {
        let sides = [l, w, h].sorted()
        return 2 * sides[0] + 2 * sides[1]
    }

    var totalRibbon: Int {
        return smallestPerimeter + volume
    }
}

let totalRibbon = packages.reduce(0) { $0 + $1.totalRibbon }

print("Total ribbon needed:", totalRibbon)
