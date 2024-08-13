//
//  Styles.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import SwiftUI

struct Styles {
    struct Colors {
        static let primary = Color("PrimaryColor")
        static let secondary = Color("SecondaryColor")
        static let background = Color("BackgroundColor")
        static let textPrimary = Color("TextPrimaryColor")
        static let textSecondary = Color("TextSecondaryColor")
        static let buttonText = Color("buttonText")
        static let progressBar = Color("progressBar")
        static let circleBack = Color("circleBack")
        static let sections = Color("sections")
    }
    struct Fonts {
        static let largeTitle = Font.system(size: 32, weight: .bold)
        static let title = Font.system(size: 22, weight: .bold)
        static let body = Font.system(size: 16, weight: .regular)
        static let small = Font.system(size: 14, weight: .regular)
    }
    struct Images {
        static let coinBackground = Image("CoinBackground")
        static let iconCard = Image("iconcard")
    }
}

