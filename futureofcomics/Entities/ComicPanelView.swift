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
    @IBInspectable var traslationEndX: CGFloat = 0 {
        didSet {
            traslationEndX = max(-1,min(1,traslationEndX))
        }
    }
    @IBInspectable var traslationEndY: CGFloat = 0 {
        didSet {
            traslationEndX = max(-1,min(1,traslationEndX))
        }
    }
    //MARK: Scale
    @IBInspectable var scaleEndX: CGFloat = 1 {
        didSet {
            scaleEndX = max(0,scaleEndX)
        }
    }
    @IBInspectable var scaleEndY: CGFloat = 1 {
        didSet {
            scaleEndY = max(0,scaleEndY)
        }
    }
    //MARK: Rotation
    @IBInspectable var rotationEndDegrees: CGFloat = 0 {
        didSet {
            rotationEndDegrees = max(-360,min(360,rotationEndDegrees))
        }
    }
    
    //MARK: - Private properties
    //MARK: General
    private var centerY: CGFloat {
        return convert(bounds, to: nil).midY
    }
    private var startCenterY: CGFloat {
        return UIScreen.main.bounds.midY
    }
    private var endCenterY: CGFloat {
        let maxDifference = UIScreen.main.bounds.height/4
        return startCenterY - maxDifference
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
    //MARK: Scale
    private let scaleStartX: CGFloat = 1
    private let scaleStartY: CGFloat = 1
    //MARK: Rotation
    private let rotationStartDegrees:CGFloat = 0
    
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
        func transformTraslation() -> CGAffineTransform{
            let traslationX = mapCenterY(toStart:traslationStartX,toEnd: traslationEndX) * screenWidth
            let traslationY = mapCenterY(toStart:traslationStartY,toEnd: traslationEndY) * screenHeight
            return CGAffineTransform(translationX: traslationX, y: traslationY)
        }
        
        func transformScale() -> CGAffineTransform{
            let scaleX = mapCenterY(toStart:scaleStartX,toEnd: scaleEndX)
            let scaleY = mapCenterY(toStart:scaleStartY,toEnd: scaleEndY)
            return CGAffineTransform(scaleX: scaleX, y: scaleY)
        }
        
        func transformRotation() -> CGAffineTransform{
            let rotationDegrees = mapCenterY(toStart: rotationStartDegrees,toEnd: rotationEndDegrees)
            let rotationAngle = map(value: rotationDegrees, fromStart: -360, fromEnd:360, toStart: -2*CGFloat.pi, toEnd: 2*CGFloat.pi)
            return CGAffineTransform(rotationAngle: rotationAngle)
        }
        
        //
        guard canReact else {
            transform = CGAffineTransform.identity
            return
        }
        
        let traslationTransform = transformTraslation()
        let scaleTransform = transformScale()
        let rotationTransform = transformRotation()
        
        let groupTransform = traslationTransform.concatenating(scaleTransform).concatenating(rotationTransform)
        transform = groupTransform
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
