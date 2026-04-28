import Foundation

extension URL {
    var isLyrics: Bool {
        self.path.contains("color-lyrics/v2")
    }
    
    var isPlanOverview: Bool {
        self.path.contains("GetPlanOverview")
    }
    
    var isPremiumPlanRow: Bool {
        self.path.contains("v1/GetPremiumPlanRow")
    }
    
    var isPremiumBadge: Bool {
        self.path.contains("GetYourPremiumBadge")
    }

    var isOpenSpotifySafariExtension: Bool {
        self.host == "eevee"
    }
    
    var isCustomize: Bool {
        self.path.contains("v1/customize")
    }
    
    var isBootstrap: Bool {
        self.path.contains("v1/bootstrap")
    }
    
    var isAdRelated: Bool {
        guard let host = self.host else { return false }
        return host.contains("audio-ads.spotify.com") ||
               host.contains("adeventtracker.spotify.com") ||
               host.contains("spclient.wg.spotify.com") && self.path.contains("ad-logic") ||
               self.path.contains("v1/ads")
    }
}
