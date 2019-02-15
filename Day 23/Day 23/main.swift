//
//  main.swift
//  Day 23
//
//  Created by Peter Bohac on 2/14/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct Instruction {
    enum Operation {
        case hlf, tpl, inc, jmp, jie, jio
    }

    let op: Operation
    let register: String?
    let value: Int?
}

extension Instruction {
    private init(string: Substring) {
        let words = string.split(separator: " ")
        switch words[0] {
        case "hlf":
            self.op = .hlf
            self.register = String(words[1])
            self.value = nil

        case "tpl":
            self.op = .tpl
            self.register = String(words[1])
            self.value = nil

        case "inc":
            self.op = .inc
            self.register = String(words[1])
            self.value = nil

        case "jmp":
            self.op = .jmp
            self.register = nil
            self.value = Int(String(words[1]))!

        case "jie":
            self.op = .jie
            self.register = String(words[1].dropLast())
            self.value = Int(String(words[2]))!

        case "jio":
            self.op = .jio
            self.register = String(words[1].dropLast())
            self.value = Int(String(words[2]))!

        default:
            preconditionFailure()
        }
    }

    static func load(from input: String) -> [Instruction] {
        return input.split(separator: "\n").map(Instruction.init)
    }
}

final class Program {
    let instructions: [Instruction]
    var ip: Int
    var registers: [String: Int]

    init(input: String) {
        self.instructions = Instruction.load(from: input)
        self.ip = 0
        self.registers = [:]
    }

    func run(registerA: Int = 0, registerB: Int = 0) {
        ip = 0
        registers = ["a": registerA, "b": registerB]

        while ip >= 0 && ip < instructions.count {
            execute(instructions[ip])
        }
    }

    private func execute(_ instr: Instruction) {
        switch instr.op {
        case .hlf:
            let r = instr.register!
            let value = registers[r]!
            registers[r] = value / 2
            ip += 1

        case .tpl:
            let r = instr.register!
            let value = registers[r]!
            registers[r] = value * 3
            ip += 1

        case .inc:
            let r = instr.register!
            let value = registers[r]!
            registers[r] = value + 1
            ip += 1

        case .jmp:
            let offset = instr.value!
            ip += offset

        case .jie:
            let r = instr.register!
            let value = registers[r]!
            let offset = instr.value!
            ip += value % 2 == 0 ? offset : 1

        case .jio:
            let r = instr.register!
            let value = registers[r]!
            let offset = instr.value!
            ip += value == 1 ? offset : 1
        }
    }
}

let program = Program(input: InputData.challenge)
program.run(registerA: 1)
print("Register A:", program.registers["a"]!)
print("Register B:", program.registers["b"]!)
