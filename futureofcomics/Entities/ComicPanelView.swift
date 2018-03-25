//
//  ComicPanelView.swift
//  futureofcomics
//
//  Created by Diego Cruz on 2/23/18.
//  Copyright © 2018 Diego Cruz. All rights reserved.
//

import UIKit

class ComicPanelView: UIView {
    //MARK: - Public properties
    @IBInspectable var canReact: Bool = true
    //MARK: Traslation
    @IBInspectable var moveXBy: CGFloat = 0
    @IBInspectable var moveYBy: CGFloat = 0
    @IBInspectable var scaleBy: CGFloat = 1
    @IBInspectable var rotateBy: CGFloat = 0
    
    //MARK: - Private properties
    //MARK: General
    private var centerY: CGFloat {
        return convert(bounds, to: nil).midY
    }
    private var startCenterY: CGFloat {
        return UIScreen.main.bounds.midY + UIScreen.main.bounds.height/4
    }
    private var endCenterY: CGFloat {
        return UIScreen.main.bounds.midY - UIScreen.main.bounds.height/4
    }
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    //MARK: Traslation
    private let traslationStartX: CGFloat = 0
    private let traslationStartY: CGFloat = 0
    private var traslationEndX: CGFloat {
        return max(-1,min(1,moveXBy))
    }
    private var traslationEndY: CGFloat {
        return max(-1,min(1,moveYBy))
    }
    //MARK: Scale
    private let scaleStartX: CGFloat = 1
    private let scaleStartY: CGFloat = 1
    private var scaleEndX: CGFloat {
        return max(0,scaleBy)
    }
    private var scaleEndY: CGFloat {
        return max(0,scaleBy)
    }
    //MARK: Rotation
    private let rotationStartDegrees:CGFloat = 0
    private var rotationEndDegrees: CGFloat {
        return max(-360,min(360,rotateBy))
    }
    
    //MARK: - Public methods
    public func react() {
        guard canReact else {
            return
        }
        
        refreshTransform()
    }
    
    //MARK: - Private methods
    //MARK: Transform
    private func refreshTransform() {
        func translate(transform: CGAffineTransform) -> CGAffineTransform{
            let traslationX = mapCenterY(toStart:traslationStartX,toEnd: traslationEndX) * screenWidth
            let traslationY = mapCenterY(toStart:traslationStartY,toEnd: traslationEndY) * screenHeight
            return transform.translatedBy(x: traslationX, y: traslationY)
        }
        
        func scale(transform: CGAffineTransform) -> CGAffineTransform{
            let scaleX = mapCenterY(toStart:scaleStartX,toEnd: scaleEndX)
            let scaleY = mapCenterY(toStart:scaleStartY,toEnd: scaleEndY)
            return transform.scaledBy(x: scaleX, y: scaleY)
        }
        
        func rotate(transform: CGAffineTransform) -> CGAffineTransform{
            let rotationDegrees = mapCenterY(toStart: rotationStartDegrees,toEnd: rotationEndDegrees)
            let rotationAngle = map(value: rotationDegrees, fromStart: -360, fromEnd:360, toStart: -2*CGFloat.pi, toEnd: 2*CGFloat.pi)
            return transform.rotated(by: rotationAngle)
        }
        
        //
        guard canReact else {
            layer.zPosition = 0
            transform = CGAffineTransform.identity
            return
        }
        
        layer.zPosition = 1
        let translatedTransform = translate(transform: CGAffineTransform.identity)
        let translatedAndScaledTransform = scale(transform: translatedTransform)
        let translatedAndScaledAndRotateTransform = rotate(transform: translatedAndScaledTransform)
        
        transform = translatedAndScaledAndRotateTransform
    }
    
    //MARK: Util
    private func mapCenterY(toStart:CGFloat, toEnd:CGFloat) -> CGFloat {
        return map(value: centerY, fromStart: startCenterY, fromEnd: endCenterY,toStart: toStart,toEnd: toEnd)
    }
    
    private func map(value:CGFloat, fromStart: CGFloat, fromEnd:CGFloat, toStart: CGFloat, toEnd:CGFloat) -> CGFloat {
        let fromMin = min(fromStart,fromEnd)
        let fromMax = max(fromStart, fromEnd)
        let correctedValue = max(fromMin,min(fromMax,value))
        return toStart + (toEnd - toStart) * (correctedValue - fromStart) / (fromEnd - fromStart)
    }
}
