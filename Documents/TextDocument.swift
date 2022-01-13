//
//  TextDocument.swift
//  codeLab
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

class TextDocument: UIDocument {

    var userText: String? = ""

    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }

    override func contents(forType typeName: String) throws -> Any {
        if let content = userText {
            let length = content.lengthOfBytes(using: String.Encoding.utf8)
            return NSData(bytes: content, length: length)
        } else {
            return Data()
        }
    }

    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let userContent = contents as? Data {
            if let bytes = (userContent as AnyObject).bytes {
                userText =
                    NSString(
                        bytes: bytes, length: userContent.count,
                        encoding: String.Encoding.utf8.rawValue) as String?
            }
        }
    }

}
