//
//  main.swift
//  Day 04
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

var count = 0
while "yzbqklnj\(count)".md5.hasPrefix("000000") == false {
    count += 1
}

print(count)
