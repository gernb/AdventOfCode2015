//
//  main.swift
//  Day 15
//
//  Created by Peter Bohac on 2/12/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

/*
 Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
 Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
*/
struct Ingredient {
    let name: String
    let capacity: Int
    let durability: Int
    let flavor: Int
    let texture: Int
    let calories: Int
}

extension Ingredient {
    private init(string: Substring) {
        let words = string.split(separator: " ")
        self.name = String(words[0].dropLast())

        var index = words.firstIndex(of: "capacity")! + 1
        self.capacity = Int(words[index].hasSuffix(",") ? String(words[index].dropLast()) : String(words[index]))!

        index = words.firstIndex(of: "durability")! + 1
        self.durability = Int(words[index].hasSuffix(",") ? String(words[index].dropLast()) : String(words[index]))!

        index = words.firstIndex(of: "flavor")! + 1
        self.flavor = Int(words[index].hasSuffix(",") ? String(words[index].dropLast()) : String(words[index]))!

        index = words.firstIndex(of: "texture")! + 1
        self.texture = Int(words[index].hasSuffix(",") ? String(words[index].dropLast()) : String(words[index]))!

        index = words.firstIndex(of: "calories")! + 1
        self.calories = Int(words[index].hasSuffix(",") ? String(words[index].dropLast()) : String(words[index]))!
    }

    static func load(from input: String) -> [Ingredient] {
        return input.split(separator: "\n").map(Ingredient.init)
    }
}

struct Recipe {
    let amounts: [(ingredient: Ingredient, teaspoons: Int)]

    init(_ amounts: [(ingredient: Ingredient, teaspoons: Int)]) {
        let total = amounts.reduce(0) { $0 + $1.teaspoons }
        assert(total == 100)
        self.amounts = amounts
    }

    var score: Int {
        let capacity = amounts.reduce(0) { $0 + $1.teaspoons * $1.ingredient.capacity }
        let durability = amounts.reduce(0) { $0 + $1.teaspoons * $1.ingredient.durability }
        let flavor = amounts.reduce(0) { $0 + $1.teaspoons * $1.ingredient.flavor }
        let texture = amounts.reduce(0) { $0 + $1.teaspoons * $1.ingredient.texture }
        if capacity < 0 || durability < 0 || flavor < 0 || texture < 0 {
            return 0
        }
        return capacity * durability * flavor * texture
    }
}

let ingredients = Ingredient.load(from: InputData.challenge)

func findBestRecipe(using ingredients: [Ingredient]) -> Recipe {
    var best: Recipe?

    for amount1 in 0 ... 100 {
        for amount2 in 0 ... (100 - amount1) {
            for amount3 in 0 ... (100 - amount1 - amount2) {
                let amount4 = 100 - amount1 - amount2 - amount3
                let amounts = [
                    (ingredients[0], amount1),
                    (ingredients[1], amount2),
                    (ingredients[2], amount3),
                    (ingredients[3], amount4),
                ]
                let recipe = Recipe(amounts)
                if let currentBest = best {
                    if recipe.score > currentBest.score {
                        best = recipe
                    }
                } else {
                    best = recipe
                }
            }
        }
    }

    return best!
}

let bestRecipe = findBestRecipe(using: ingredients)
print("Best recipe score:", bestRecipe.score)

// MARK: Part 2

extension Recipe {
    var calories: Int {
        return amounts.reduce(0) { $0 + $1.teaspoons * $1.ingredient.calories }
    }
}

func findBest500CalRecipe(using ingredients: [Ingredient]) -> Recipe {
    var best: Recipe?

    for amount1 in 0 ... 100 {
        for amount2 in 0 ... (100 - amount1) {
            for amount3 in 0 ... (100 - amount1 - amount2) {
                let amount4 = 100 - amount1 - amount2 - amount3
                let amounts = [
                    (ingredients[0], amount1),
                    (ingredients[1], amount2),
                    (ingredients[2], amount3),
                    (ingredients[3], amount4),
                ]
                let recipe = Recipe(amounts)
                guard recipe.calories == 500 else { continue }
                if let currentBest = best {
                    if recipe.score > currentBest.score {
                        best = recipe
                    }
                } else {
                    best = recipe
                }
            }
        }
    }

    return best!
}

let best500CalCookie = findBest500CalRecipe(using: ingredients)
print("Best 500 calorie cookie:", best500CalCookie.score)
