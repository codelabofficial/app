//
//  Settings.swift
//  
//
//  Created by Alfie on 13/01/2022.
//

import Foundation
import UIKit

enum FontStyle: Int {
    case monoSpace, serif, sansSerif
    
    var uiFont: UIFont {
        switch self {
        case .monoSpace:
            return .SFMono(ofSize: Settings.fontSize)
        case .serif:
            return .NY(ofSize: Settings.fontSize)
        case .sansSerif:
            return .SF(ofSize: Settings.fontSize)
        }
    }
}

enum InterfaceStyle: Int {
    case system, light, dark
    
    var uiUserInterfaceStyle : UIUserInterfaceStyle {
        return UIUserInterfaceStyle(rawValue: self.rawValue) ?? .unspecified
    }
    
    var uiKeyboardAppearance : UIKeyboardAppearance {
        switch self {
        case .system : return .default
        case .light  : return .light
        case .dark   : return .dark
        }
    }
}

struct Settings {
    
    struct Keys {
        static var fontStyle                  = "codeLab_FontStyle"
        static var fontSize                   = "codeLab_FontSize"
        static var caseSensitiveTextSearching = "codeLab_CaseSensitiveTextSearching"
        static var syntaxHighlight            = "codeLab_SyntaxHighlight"
        static var interfaceStyle             = "codeLab_InterfaceStyle"
        static var syntaxThemeID              = "codeLab_SyntaxThemeID"
    }

    static var fontStyle: FontStyle {
        get {
            let raw = UserDefaults.standard.integer(forKey: Settings.Keys.fontStyle)
            return FontStyle(rawValue: raw) ?? FontStyle.monoSpace
        }
        set(newFontType) {
            let raw = newFontType.rawValue
            UserDefaults.standard.set(raw, forKey: Settings.Keys.fontStyle)
        }
    }

    static var fontSize: CGFloat {
        get {
            return CGFloat(UserDefaults.standard.float(forKey: Settings.Keys.fontSize))
        }
        set(newSize) {
            UserDefaults.standard.set(newSize, forKey: Settings.Keys.fontSize)
        }
    }

    static var caseSensitiveTextSearching: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Settings.Keys.caseSensitiveTextSearching)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Settings.Keys.caseSensitiveTextSearching)
        }
    }

    static var enableSyntaxHighlight: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Settings.Keys.syntaxHighlight)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Settings.Keys.syntaxHighlight)
        }
    }
    
    static var interfaceStyle: InterfaceStyle {
        get {
            let raw = UserDefaults.standard.integer(forKey: Settings.Keys.interfaceStyle)
            return InterfaceStyle(rawValue: raw) ?? .system
        }
        set(newValue) {
            let raw = newValue.rawValue
            UserDefaults.standard.set(raw, forKey: Settings.Keys.interfaceStyle)
            NotificationCenter.default.post(Notification(name: .InterfaceStyleChanged))
        }
    }
    
    static var syntaxTheme: SyntaxTheme {
        get {
            if let id = UserDefaults.standard.string(forKey: Settings.Keys.syntaxThemeID) {
                return ThemesManager.theme(of: id)!
            } else {
                return ThemesManager.theme(of: "basic")!
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue.id, forKey: Settings.Keys.syntaxThemeID)
        }
    }
    
    static var syntaxThemeID: String {
        get {
            if let id = UserDefaults.standard.string(forKey: Settings.Keys.syntaxThemeID) {
                return id
            } else {
                return "basic"
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Settings.Keys.syntaxThemeID)
        }
    }
    
}
