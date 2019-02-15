//
//  InputData.swift
//  Day 24
//
//  Created by Peter Bohac on 2/14/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

struct InputData {
    static let example = """
1
2
3
4
5
7
8
9
10
11
""".split(separator: "\n").map { Int(String($0))! }

    static let challenge = """
1
3
5
11
13
17
19
23
29
31
37
41
43
47
53
59
67
71
73
79
83
89
97
101
103
107
109
113
""".split(separator: "\n").map { Int(String($0))! }
}
