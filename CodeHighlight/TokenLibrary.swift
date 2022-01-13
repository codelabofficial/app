//
//  TokenLibrary.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation

struct LibrariesManager {
    
    private init() {}
    
    static var libraries = [TokenLibrary]()
    
    static func library(of id: String) -> TokenLibrary? {
        for library in LibrariesManager.libraries {
            if library.id == id {
                return library
            }
        }
        return nil
    }
    
    static func hasLibrary(of id: String?) -> Bool {
        guard id != nil else { return false }
        for library in LibrariesManager.libraries {
            if library.id == id {
                return true
            }
        }
        return false
    }
    
}

struct TokenLibrary: Codable {
    
    var id          : String
    var keywords    : [Token]?
    var types       : [Token]?
    var comments    : [Token]?
    var numbers     : [Token]?
    var strings     : [Token]?
    var identifiers : [Token]?
    var macros      : [Token]?
    
}
