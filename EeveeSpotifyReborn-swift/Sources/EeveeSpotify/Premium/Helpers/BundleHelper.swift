import Foundation
import SwiftUI
import libroot

enum BundleHelperError: Error {
    case missingBundle
    case missingLocalization
    case missingImage
    case missingResolveConfiguration
}

class BundleHelper {
    private let bundleName = "EeveeSpotify"
    
    private let bundle: Bundle
    private let enBundle: Bundle
    
    static let shared = BundleHelper()
    
    private init() {
        let bundlePath =
            Bundle.main.path(forResource: bundleName, ofType: "bundle")
            ?? jbRootPath("/Library/Application Support/\(bundleName).bundle")

        if let bundle = Bundle(path: bundlePath) {
            self.bundle = bundle
        }
        else {
            NSLog("[EeveeSpotify] Unable to locate \(bundleName).bundle at \(bundlePath)")
            self.bundle = .main
        }

        if let englishPath = bundle.path(forResource: "en", ofType: "lproj"),
           let englishBundle = Bundle(path: englishPath) {
            enBundle = englishBundle
        }
        else {
            NSLog("[EeveeSpotify] Unable to locate English localization bundle")
            enBundle = bundle
        }
    }
    
    func uiImage(_ name: String) -> UIImage {
        guard let path = bundle.path(forResource: name, ofType: "png"),
              let image = UIImage(contentsOfFile: path) else {
            NSLog("[EeveeSpotify] Missing image asset: \(name).png")
            return UIImage()
        }

        return image
    }
    
    func localizedString(_ key: String) -> String {
        let value = bundle.localizedString(forKey: key, value: "No translation", table: nil)
        
        if value != "No translation" {
            return value
        }
        
        return enBundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    func resolveConfiguration() throws -> ResolveConfiguration {
        guard let url = bundle.url(
            forResource: "resolveconfiguration",
            withExtension: "bnk"
        ) else {
            throw BundleHelperError.missingResolveConfiguration
        }

        return try ResolveConfiguration(serializedBytes: Data(contentsOf: url))
    }
}
