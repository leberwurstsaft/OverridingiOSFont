//
//  UIFont+Hack.swift
//  FontTest
//
//  Created by Pit Schrader on 16.01.20.
//  Copyright © 2020 leberwurstsaft.de. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let regular = "Heartwell"
    static let bold = "Heartwell"
    static let italic = "Heartwell Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }

        if let preferredFontMethod = class_getClassMethod(self, #selector(preferredFont(forTextStyle:))),
            let myPreferredFontMethod = class_getClassMethod(self, #selector(myPreferredFont(for:))) {
            method_exchangeImplementations(preferredFontMethod, myPreferredFontMethod)
        }
    }

    @objc class func myPreferredFont(for textStyle: UIFont.TextStyle) -> UIFont {
        if (textStyle == UIFont.TextStyle.body) {
            return UIFont.systemFont(ofSize: 12)
        }
        else if (textStyle == UIFont.TextStyle.title1) {
            return UIFont.systemFont(ofSize: 40)
        }
        else if (textStyle == UIFont.TextStyle.title2) {
            return UIFont.systemFont(ofSize: 32)
        }
        else if (textStyle == UIFont.TextStyle.title3) {
            return UIFont.systemFont(ofSize: 26)
        }
        else if (textStyle == UIFont.TextStyle.callout) {
            return UIFont.systemFont(ofSize: 12)
        }
        else if (textStyle == UIFont.TextStyle.caption1) {
            return UIFont.systemFont(ofSize: 10)
        }
        else if (textStyle == UIFont.TextStyle.caption2) {
            return UIFont.systemFont(ofSize: 9)
        }
        else if (textStyle == UIFont.TextStyle.footnote) {
            return UIFont.systemFont(ofSize: 7)
        }
        else if (textStyle == UIFont.TextStyle.largeTitle) {
            return UIFont.systemFont(ofSize: 60)
        }
        else if (textStyle == UIFont.TextStyle.headline) {
            return UIFont.systemFont(ofSize: 20)
        }
        else if (textStyle == UIFont.TextStyle.subheadline) {
            return UIFont.systemFont(ofSize: 18)
        }
        else {
            return UIFont.systemFont(ofSize: 12)
        }
    }
}
