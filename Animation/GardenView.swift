//
//  GardenView.swift
//  Animation
//
//  Created by venvehuob on 2/11/20.
//  Copyright © 2020 vermamukesh. All rights reserved.
//

import UIKit

public class GardenView: UIView {
    /**
     Initializes and returns a newly allocated view object with the specified frame rectangle.
     - parameter frame:   The frame rectangle for the view
     - returns: An initialized view object.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    /// Initializes and returns a newly allocated view object.
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    /**
     Returns an object initialized from data in a given unarchiver.
     - parameter decoder:   An unarchiver object.
     - returns: self, initialized using the data in decoder.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    /// Load view from nib file
    fileprivate func commonInit() {
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        drawSky(in: rect, context: context, colorSpace: colorSpace)
        drawMountains(in: rect, in: context, with: colorSpace)
        drawGrass(in: rect, in: context, with: colorSpace)
        drawFlowers(in: rect, in: context, with: colorSpace)
    }
    private func drawSky(in rect: CGRect, context: CGContext, colorSpace: CGColorSpace) {
        // 1
        context.saveGState()
        defer { context.restoreGState() }
        
        // 2
        let baseColor = UIColor(red: 148.0 / 255.0, green: 158.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
        let middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
        let farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
        
        let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
        let locations: [CGFloat] = [0.0, 0.1, 0.25]
        
        guard let gradient = CGGradient.init(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations) else {
            return
        }
        // 3
        let startPoint = CGPoint(x: rect.size.height / 2, y: 0)
        let endPoint = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
    private func drawMountains(in rect: CGRect, in context: CGContext,
                               with colorSpace: CGColorSpace?) {
        
        context.setLineWidth(4)
        let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0,
                                blue: 67.0 / 255.0, alpha: 1)
        let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0,
                                 blue: 79.0 / 255.0, alpha: 1)
        let rectWidth = rect.size.width
        
        let mountainColors = [darkColor.cgColor, lightColor.cgColor]
        let mountainLocations: [CGFloat] = [0.1, 0.2]
        guard let mountainGrad = CGGradient.init(colorsSpace: colorSpace,
                                                 colors: mountainColors as CFArray, locations: mountainLocations) else {
                                                    return
        }
        
        let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
        let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        
        context.saveGState()
        defer { context.restoreGState() }
        
        let backgroundMountains = CGMutablePath()
        backgroundMountains.move(to: CGPoint(x: 0, y: 157), transform: .identity)
        backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157),
                                         control: CGPoint(x: 30, y: 129),
                                         transform: .identity)
        
        backgroundMountains.addCurve(to: CGPoint.init(x: 303, y: 125), control1: CGPoint.init(x: 190, y: 210), control2: CGPoint.init(x: 200, y: 70), transform: .identity)
        
        backgroundMountains.addCurve(to: CGPoint.init(x: self.frame.size.width, y: 145), control1: CGPoint.init(x: 380, y: 180), control2: CGPoint.init(x: 400, y: 138), transform: .identity)
        
        // Background Mountain Stroking
        context.addPath(backgroundMountains)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
        
        backgroundMountains.addLine(to: CGPoint(x: rectWidth, y: rect.size.width),
                                    transform: .identity)
        backgroundMountains.addLine(to: CGPoint(x: 0, y: rect.size.width),
                                    transform: .identity)
        backgroundMountains.closeSubpath()
        
        // Background Mountain Drawing
        context.addPath(backgroundMountains)
        context.clip()
        context.drawLinearGradient(mountainGrad, start: mountainStart,
                                   end: mountainEnd, options: [])
        
        // Foreground Mountains
        let foregroundMountains = CGMutablePath()
        foregroundMountains.move(to: CGPoint(x: -5, y: 190),
                                 transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190),
                                     control1: CGPoint(x: 160, y: 250),
                                     control2: CGPoint(x: 200, y: 140),
                                     transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210),
                                     control1: CGPoint(x: rectWidth - 30, y: 250),
                                     control2: CGPoint(x: rectWidth - 50, y: 170),
                                     transform: .identity)
        foregroundMountains.addLine(to: CGPoint(x: rectWidth + 5, y: 230),
                                    transform: .identity)
        foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225),
                                     control1: CGPoint(x: 300, y: 260),
                                     control2: CGPoint(x: 140, y: 215),
                                     transform: .identity)
        foregroundMountains.closeSubpath()
        
        // Foreground Mountain drawing
        context.addPath(foregroundMountains)
        context.clip()
        context.setFillColor(darkColor.cgColor)
        context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))
        
        // Foreground Mountain stroking
        context.addPath(foregroundMountains)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
    }
    private func drawGrass(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        // 1
        context.saveGState()
        defer { context.restoreGState() }
        // 3
        let lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0,
                                 blue: 95.0 / 255.0, alpha: 1)
        
        let darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0,
                                blue: 61.0 / 255.0, alpha: 1)
        
        let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
        let grassLocations: [CGFloat] = [0.3, 0.4]
        
        guard let grassGredientColors = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) else {
            return
        }
        let rectWidth = rect.size.width
        let grass = CGMutablePath()
        let y: CGFloat = 225.0
        grass.move(to: CGPoint(x: rectWidth + 5, y: y + 5), transform: .identity)
        grass.addCurve(to: CGPoint(x: -5, y: y), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215),
                       transform: .identity)
        grass.addLine(to: CGPoint(x: 0, y: rect.size.width),
                      transform: .identity)
        grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width),
                      transform: .identity)
        
        context.addPath(grass)
        context.clip()
        
        let startPoint = CGPoint(x: rect.size.height / 2, y: y)
        let endPoint = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        
        context.drawLinearGradient(grassGredientColors, start: startPoint, end: endPoint, options: [])
        context.closePath()
        
    }
    
    private func drawFlowers(in rect: CGRect, in context: CGContext,
                             with colorSpace: CGColorSpace?) {
        context.saveGState()
        defer { context.restoreGState() }
        
        // 1
        let flowerSize = CGSize(width: 300, height: 300)
        
        // 2
        guard let flowerLayer = CGLayer(context, size: flowerSize,
                                        auxiliaryInfo: nil) else {
                                            return
        }
        
        // 3
        guard let flowerContext = flowerLayer.context else {
            return
        }
        
        // Draw petals of the flower
        drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14), inDegrees: 0,
                  inContext: flowerContext)
        drawPetal(in: CGRect(x: 115, y: 236, width: 10, height: 12), inDegrees: 300,
                  inContext: flowerContext)
        drawPetal(in: CGRect(x: 120, y: 246, width: 9, height: 14), inDegrees: 5,
                  inContext: flowerContext)
        drawPetal(in: CGRect(x: 128, y: 246, width: 9, height: 14), inDegrees: 350,
                  inContext: flowerContext)
        drawPetal(in: CGRect(x: 133, y: 236, width: 11, height: 14), inDegrees: 80,
                  inContext: flowerContext)
        
        let center = CGMutablePath()
        let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
        center.addEllipse(in: ellipse, transform: .identity)
        
        let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0,
                                  blue: 49.0 / 255.0, alpha: 1.0)
        
        flowerContext.addPath(center)
        flowerContext.setStrokeColor(UIColor.black.cgColor)
        flowerContext.strokePath()
        flowerContext.setFillColor(orangeColor.cgColor)
        flowerContext.addPath(center)
        flowerContext.fillPath()
        
        flowerContext.move(to: CGPoint(x: 135, y: 249))
        context.setStrokeColor(UIColor.black.cgColor)
        flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270),
                                   control: CGPoint(x: 145, y: 250))
        flowerContext.strokePath()
        
        // Draw clones
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: 20, y: 10)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: -30, y: 5)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        context.translateBy(x: -20, y: -10)
        context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
    }
    
    private func drawPetal(in rect: CGRect, inDegrees degrees: Int,
                           inContext context: CGContext) {
        // 1
        context.saveGState()
        defer { context.restoreGState() }
        
        // 2
        let midX = rect.midX
        let midY = rect.midY
        let transform = CGAffineTransform.init(translationX: -midX, y: -midY).concatenating(CGAffineTransform.init(rotationAngle: degreesToRadians(CGFloat(degrees)))).concatenating(CGAffineTransform.init(translationX: midX, y: midY))
        let ellipsePath = CGMutablePath()
        ellipsePath.addEllipse(in: rect, transform: transform)
        context.addPath(ellipsePath)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
        context.setFillColor(UIColor.white.cgColor)
        context.addPath(ellipsePath)
        context.fillPath()
    }
    
    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return CGFloat.pi * degrees/180.0
    }
    
    private func rotatePetal(layer: CALayer) {
        
    }
    
}
