//
//  main.swift
//  Day 09
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Pair: Hashable {
    let pointA: String
    let pointB: String

    init(pointA: String, pointB: String) {
        if pointA < pointB {
            self.pointA = pointA
            self.pointB = pointB
        } else {
            self.pointA = pointB
            self.pointB = pointA
        }
    }
}

func loadDistances(from input: String) -> (distances: [Pair: Int], destinations: [String]) {
    var result: [Pair: Int] = [:]
    var destinations = Set<String>()
    input.split(separator: "\n").forEach { line in
        let words = line.split(separator: " ").map(String.init)
        let pair = Pair(pointA: words[0], pointB: words[2])
        let distance = Int(words[4])!
        assert(result[pair] == nil)
        result[pair] = distance
        destinations.insert(words[0])
        destinations.insert(words[2])
    }
    return (result, destinations.sorted())
}

extension Array where Element: Equatable {
    var permutations: [[Element]] {
        guard self.count > 1 else { return [self] }
        return self.flatMap { element in
            return self.removing(element).permutations.map { [element] + $0 }
        }
    }

    func removing(_ element: Element) -> [Element] {
        guard let index = firstIndex(where: { $0 == element }) else { return self }
        var result = self
        result.remove(at: index)
        return result
    }
}

let (distances, destinations) = loadDistances(from: InputData.challenge)

let routes = destinations.permutations.map { destinationList in
    return destinationList.dropLast().enumerated().map { i, destination in Pair(pointA: destination, pointB: destinationList[i + 1]) }
}

let routeDistances = routes.map { route -> (route: [Pair], length: Int) in
    let distance = route.reduce(0) { $0 + distances[$1]! }
    return (route, distance)
}

let shortest = routeDistances.min { $0.length < $1.length }!
print("Shortest route:", shortest.length)

let longest = routeDistances.max { $0.length < $1.length }!
print("Longest route:", longest.length)
