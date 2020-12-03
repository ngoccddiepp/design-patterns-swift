/*
 The monostate pattern is another way to achieve singularity.
 It works through a completely different mechanism,
 it enforces the behavior of singularity without imposing structural constraints.
 So in that case, monostate saves the state as static instead of the entire instance as a singleton.
 
 Link: http://staff.cs.utu.fi/~jounsmed/doos_06/material/SingletonAndMonostate.pdf
 */

import UIKit

struct Settings {
    enum Theme {
        case old
        case new
    }

    private static var theme: Theme = .old

    var currentTheme: Theme {
        get { Settings.theme }
        set(newTheme) { Settings.theme = newTheme }
    }
}

// MARK: - Usage:

// When change the theme
var settings = Settings() // Starts using theme .old
settings.currentTheme = .new // Change theme to .new

var settings1 = Settings()
settings1.currentTheme = .old

//On screen 1
let screenColor: UIColor = Settings().currentTheme == .old ? .gray : .white

//On screen 2
let screenTitle: String = Settings().currentTheme == .old ? "Itunes Connect" : "App Store Connect"
