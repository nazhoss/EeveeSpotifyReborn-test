import Orion
import UIKit

class UIOpenURLContextHook: ClassHook<UIOpenURLContext> {
    func URL() -> URL {
        let url = orig.URL()

        if url.isOpenSpotifySafariExtension {
            if let redirectUrl = Foundation.URL(string: "https:/\(url.path)") {
                return redirectUrl
            }
        }

        return url
    }
}
