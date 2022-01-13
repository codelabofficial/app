//
//  AppDelegate.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//        if !launchedBefore {
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//
//            // Initialize Settings
//            Settings.fontStyle = .monoSpace
//            Settings.fontSize = 18
//            Settings.caseSensitiveTextSearching = false
//            Settings.enableSyntaxHighlight = true
//        }
        CodeHighlighter.loadLibraries()
        CodeHighlighter.loadThemes()
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(
        _ app: UIApplication, open inputURL: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Ensure the URL is a file URL
        guard inputURL.isFileURL else { return false }

        // Reveal / import the document at the URL
        guard
            let documentBrowserViewController = window?.rootViewController
                as? BrowserViewController
        else { return false }

        documentBrowserViewController.revealDocument(at: inputURL, importIfNeeded: true) {
            (revealedDocumentURL, error) in
            if let error = error {
                // Handle the error appropriately
                print("Failed to reveal the document at URL \(inputURL) with error: '\(error)'")
                return
            }

            // Present the Document View Controller for the revealed URL
            documentBrowserViewController.presentDocument(at: revealedDocumentURL!)
        }

        return true
    }

}

