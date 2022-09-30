//
//  ShadowView.swift
//  SeatGeekAPI
//
//  Created by J.A. Ramirez on 12/27/20.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    
    private func addShadow() {
        // Take off background color here so we can still see it in xib view if needed.
        backgroundColor = .white
        
        // layer is from Core Animation (CA), which uses Core Graphics (CG), so you cannot use UIColor.
        layer.shadowColor = UIColor.black.cgColor
    }
}
