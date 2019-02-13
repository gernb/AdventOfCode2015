//
//  main.swift
//  Day 12
//
//  Created by Bohac, Peter on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> [Range<String.Index>] {
        let range = NSRange(string.startIndex..., in: string)
        return matches(in: string, range: range).map { result in
            return Range(result.range, in: string)!
        }
    }
}

//let example = "{\"a\":{\"b\":4},\"c\":-1}"
let numberRegex = try! NSRegularExpression(pattern: "(-?[0-9]+)")
let numbers = numberRegex.matches(InputData.challenge)
    .map { Int(String(InputData.challenge[$0]))! }

let sum = numbers.reduce(0, +)

print("Sum:", sum)

// MARK: Part 2

func sumNumbers(in json: Any) -> Int {
    if let number = json as? Int {
        return number
    } else if let array = json as? [Any] {
        return array.reduce(0) { $0 + sumNumbers(in: $1) }
    } else if let dict = json as? [String: Any] {
        if dict.values.contains(where: { ($0 as? String) == "red" }) {
            return 0
        }
        return dict.values.reduce(0) { $0 + sumNumbers(in: $1) }
    } else {
        return 0
    }
}

let data = InputData.challenge.data(using: .utf8)!
let json = try! JSONSerialization.jsonObject(with: data)
let sum2 = sumNumbers(in: json)

print("Sum (excluding 'red'):", sum2)
