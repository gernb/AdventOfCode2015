//
//  main.swift
//  Day 07
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

//enum Component: Equatable {
//    case set(value: UInt16, wire: String)
//    case setFromWire(x: String, wire: String)
//    case and(x: String, y: String, wire: String)
//    case or(x: String, y: String, wire: String)
//    case lshift(x: String, count: Int, wire: String)
//    case rshift(x: String, count: Int, wire: String)
//    case not(x: String, wire: String)
//}

typealias Wires = [String: UInt16]

struct Component: Equatable {
    enum Gate {
        case set, and, or, lshift, rshift, not
    }

    let rawValue: String
    let gate: Gate
    let output: String
    let xWire: String?
    let xValue: UInt16?
    let yWire: String?
    let yValue: UInt16?

    init(string: Substring) {
        self.rawValue = String(string)
        var gate: Gate
        var output: String
        var xWire: String?
        var yWire: String?
        var xValue: UInt16?
        var yValue: UInt16?

        let words = string.split(separator: " ").map(String.init)
        output = words.last!

        if words.count == 3 {
            gate = .set
            if let value = UInt16(words[0]) {
                xValue = value
            } else {
                xWire = words[0]
            }
        } else if words[0] == "NOT" {
            gate = .not
            if let value = UInt16(words[1]) {
                xValue = value
            } else {
                xWire = words[1]
            }
        } else {
            if let value = UInt16(words[0]) {
                xValue = value
            } else {
                xWire = words[0]
            }
            if let value = UInt16(words[2]) {
                yValue = value
            } else {
                yWire = words[2]
            }
            switch words[1] {
            case "AND": gate = .and
            case "OR": gate = .or
            case "LSHIFT": gate = .lshift
            case "RSHIFT": gate = .rshift
            default: preconditionFailure()
            }
        }

        self.gate = gate
        self.output = output
        self.xWire = xWire
        self.yWire = yWire
        self.xValue = xValue
        self.yValue = yValue
    }

    func isReady(wires: Wires) -> Bool {
        switch gate {
        case .set, .not:
            let input = xValue ?? wires[xWire!]
            return input != nil
        case .and, .or, .lshift, .rshift:
            let input1 = xValue ?? wires[xWire!]
            let input2 = yValue ?? wires[yWire!]
            return input1 != nil && input2 != nil
        }
    }

    func evaluate(wires: inout Wires) {
        assert(isReady(wires: wires))
        switch gate {
        case .set:
            let input = xValue ?? wires[xWire!]!
            wires[output] = input
        case .not:
            let input = xValue ?? wires[xWire!]!
            wires[output] = ~input
        case .and:
            let input1 = xValue ?? wires[xWire!]!
            let input2 = yValue ?? wires[yWire!]!
            wires[output] = input1 & input2
        case .or:
            let input1 = xValue ?? wires[xWire!]!
            let input2 = yValue ?? wires[yWire!]!
            wires[output] = input1 | input2
        case .lshift:
            let input1 = xValue ?? wires[xWire!]!
            let input2 = yValue ?? wires[yWire!]!
            wires[output] = input1 << input2
        case .rshift:
            let input1 = xValue ?? wires[xWire!]!
            let input2 = yValue ?? wires[yWire!]!
            wires[output] = input1 >> input2
        }
    }
}

extension Array where Element: Equatable {
    @discardableResult
    mutating func remove(_ element: Element) -> Element? {
        guard let index = self.firstIndex(of: element) else { return nil }
        return self.remove(at: index)
    }
}

final class Circuit {
    let components: [Component]

    init(input: String) {
        self.components = input.split(separator: "\n").map(Component.init)
    }

    func evaluate() -> Wires {
        var components = self.components
        var wires: Wires = [:]

        while let nextComponent = components.first(where: { $0.isReady(wires: wires) }) {
            nextComponent.evaluate(wires: &wires)
            components.remove(nextComponent)
        }

        return wires
    }

    func evaluate2() -> Wires {
        var components = self.components
        var wires: Wires = [:]

        while let nextComponent = components.first(where: { $0.isReady(wires: wires) }) {
            if nextComponent.output == "b" {
                wires["b"] = 956
            } else {
                nextComponent.evaluate(wires: &wires)
            }
            components.remove(nextComponent)
        }

        return wires
    }
}

let circuit = Circuit(input: InputData.challenge)

let output = circuit.evaluate()
print("Wire a:", output["a"])

let output2 = circuit.evaluate2()
print("Wire a:", output2["a"])
