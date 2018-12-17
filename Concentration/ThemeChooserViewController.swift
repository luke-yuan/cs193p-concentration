//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Luke on 7/19/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    let themes = ["Technology": "🖥⌚️📺📞💽💾⌨️💻", "Sports": "⚽️🎾🏀🏈⚾️🎱🏑🏐", "Food": "🍟🌮🍱🍪🍵🍣🍕🥦"]


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let title = (sender as? UIButton)?.currentTitle, let theme = themes[title] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }

}
