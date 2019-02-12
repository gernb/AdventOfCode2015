//
//  String+md5.swift
//  Day 04
//
//  Created by Peter Bohac on 2/11/19.
//  Copyright © 2019 Peter Bohac. All rights reserved.
//

import CommonCrypto
import Foundation

extension UInt8 {
    var hexString: String {
        let upperNibble = (self >> 4) & 0xF
        let lowerNibble = self & 0xF
        let chars = [ upperNibble, lowerNibble ].map { nibble -> String in
            switch nibble {
            case 0: return "0"
            case 1: return "1"
            case 2: return "2"
            case 3: return "3"
            case 4: return "4"
            case 5: return "5"
            case 6: return "6"
            case 7: return "7"
            case 8: return "8"
            case 9: return "9"
            case 10: return "a"
            case 11: return "b"
            case 12: return "c"
            case 13: return "d"
            case 14: return "e"
            case 15: return "f"
            default: preconditionFailure()
            }
        }
        return chars[0] + chars[1]
    }
}

extension String {
    var md5: String {
        let messageData = self.data(using: .utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { $0.hexString }.joined()
    }
}
