//
//  Extensions.swift
//  2paraStyleRu
//
//  Created by Ирина Улитина on 05/10/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
}
