//
//  ViewController.swift
//  Animation
//
//  Created by venvehuob on 22/10/20.
//  Copyright © 2020 vermamukesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myView = UIView()
    var shapeLayer = CAShapeLayer()
    @IBOutlet var gardenView: GardenView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        gardenView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func movex() {
        
        let frame = CGRect(origin: CGPoint.init(x: 0, y: 100), size: CGSize(width: 100, height: 100))
        myView = UIView(frame: frame)
        myView.backgroundColor = .black
        view.addSubview(myView)
        
        let basicXAnimation = CABasicAnimation.init(keyPath: "position.x")
        basicXAnimation.fromValue = CGPoint.init(x: 0, y: 100)
        basicXAnimation.toValue = self.view.frame.size.width
        basicXAnimation.duration = 1.0
        basicXAnimation.delegate = self
        basicXAnimation.autoreverses = true
        basicXAnimation.beginTime = CACurrentMediaTime() + 0.3
        basicXAnimation.repeatCount = 2
        
        myView.layer.add(basicXAnimation, forKey: nil)
    }
    
    @IBAction func movey() {
        
        let frame = CGRect(origin: CGPoint.init(x: 0, y: 100), size: CGSize(width: 100, height: 100))
        myView = UIView(frame: frame)
        myView.backgroundColor = .black
        view.addSubview(myView)
        
        let basicXAnimation = CABasicAnimation.init(keyPath: "position.y")
        basicXAnimation.fromValue = CGPoint.init(x: 0, y: 100)
        basicXAnimation.toValue = self.view.frame.size.height
        basicXAnimation.duration = 1.0
        basicXAnimation.delegate = self
        basicXAnimation.autoreverses = true
        basicXAnimation.beginTime = CACurrentMediaTime() + 0.3
        basicXAnimation.repeatCount = 2
        
        myView.layer.add(basicXAnimation, forKey: nil)
    }
    
    @IBAction func spring() {
        
        let frame = CGRect(origin: CGPoint.init(x: self.view.center.x - 50, y: self.view.center.y - 50), size: CGSize(width: 100, height: 100))
        myView = UIView(frame: frame)
        myView.backgroundColor = .black
        view.addSubview(myView)
        
        let jumpAnimation = CASpringAnimation.init(keyPath: "transform.scale")
        jumpAnimation.delegate = self
        jumpAnimation.damping = 20
        jumpAnimation.mass = 1
        jumpAnimation.fromValue = 1
        jumpAnimation.toValue = 2
        jumpAnimation.initialVelocity = 20
        jumpAnimation.duration = jumpAnimation.settlingDuration
        
        myView.layer.add(jumpAnimation, forKey: nil)
    }
    
    @IBAction func dropShape() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        let height: CGFloat = 200
        let shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        self.shapeLayer = shapeLayer
        
        let path = CGMutablePath()
        let dropLocation = self.view.center
        path.move(to: dropLocation)
        path.addCurve(to: dropLocation, control1: CGPoint(x: dropLocation.x + (height), y: dropLocation.y + height), control2: CGPoint(x: dropLocation.x - (height), y: dropLocation.y + height))
        
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.systemOrange.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = path
        
        animateSliceInPieChart(layer: shapeLayer, beginTime: 0, duration: 2.0)
    }
    
    @IBAction func circleShape() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        let shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        self.shapeLayer = shapeLayer
        
        let height: CGFloat = 150
        
        let path = UIBezierPath()
        path.move(to: view.center)
        path.addLine(to: CGPoint(x: view.center.x + height, y: view.center.y))
        path.move(to: view.center)
        path.addLine(to: CGPoint(x: view.center.x - height, y: view.center.y))
        path.move(to: view.center)
        path.addLine(to: CGPoint(x: view.center.x, y: view.center.y + height))
        path.move(to: view.center)
        path.addLine(to: CGPoint(x: view.center.x, y: view.center.y - height))
        
        var currentLocation = CGPoint.init(x: view.center.x - height, y: view.center.y - height)
        path.move(to: currentLocation)
        currentLocation = CGPoint.init(x: currentLocation.x, y: currentLocation.y + 2 * height)
        path.addLine(to: currentLocation)
        currentLocation = CGPoint.init(x: currentLocation.x + 2 * height, y: currentLocation.y)
        path.addLine(to: currentLocation)
        currentLocation = CGPoint.init(x: currentLocation.x, y: currentLocation.y - 2 * height)
        path.addLine(to: currentLocation)
        currentLocation = CGPoint.init(x: currentLocation.x  - 2 * height, y: currentLocation.y)
        path.addLine(to: currentLocation)
        
        path.move(to: view.center)
        
        path.lineWidth = 2
        
        path.addArc(withCenter: self.view.center, radius: height, startAngle: -.pi / 2, endAngle: .pi / 2, clockwise: false)
        
        path.move(to: CGPoint.init(x: self.view.center.x, y: self.view.center.y - height))
        
        path.addCurve(to: CGPoint.init(x: self.view.center.x + height, y: self.view.center.y), controlPoint1: CGPoint.init(x: self.view.center.x + height, y: self.view.center.y  - height), controlPoint2: self.view.center)
        
        path.move(to: CGPoint.init(x: self.view.center.x + height, y: self.view.center.y))
        
        path.addCurve(to: CGPoint.init(x: self.view.center.x, y: self.view.center.y + height), controlPoint1: CGPoint.init(x: self.view.center.x + height, y: self.view.center.y  + height), controlPoint2: self.view.center)
        
        shapeLayer.fillColor = UIColor.systemOrange.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = path.cgPath
    }
    
    @IBAction func triAngleShape() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        let shapeLayer = CAShapeLayer()
        // view.layer.mask = shapeLayer
        view.layer.addSublayer(shapeLayer)
        
        self.shapeLayer = shapeLayer
        let height: CGFloat = 300
        let halfHeight = height / 2
        let path = UIBezierPath()
        let movePoint1 = CGPoint(x: view.center.x - halfHeight, y: view.center.y + halfHeight)
        path.move(to: movePoint1)
        var currentLocation = CGPoint(x: movePoint1.x + height, y: movePoint1.y)
        path.addLine(to: currentLocation)
        currentLocation = CGPoint(x: view.center.x, y: currentLocation.y - height)
        path.addLine(to: currentLocation)
        currentLocation = CGPoint(x: currentLocation.x - halfHeight, y: currentLocation.y + height)
        path.addLine(to: currentLocation)
        
        path.lineWidth = 2
        
        shapeLayer.fillColor = UIColor.systemOrange.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3.0
        animateSliceInPieChart(layer: shapeLayer, beginTime: 0, duration: 1.0)
    }
    
    @IBAction func ovalShape() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        let width: CGFloat = 150
        let height: CGFloat = 80
        let shapeLayer = CAShapeLayer()
        let ovalPath = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: width, height: height))
        view.layer.addSublayer(shapeLayer)
        self.shapeLayer = shapeLayer
        shapeLayer.fillColor = UIColor.systemOrange.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 5.0
        shapeLayer.position = CGPoint.init(x: self.view.center.x - width / 2, y: self.view.center.y - height / 2)
        shapeLayer.path = ovalPath.cgPath
        
        animateSliceInPieChart(layer: shapeLayer, beginTime: 0, duration: 2.0)
    }
    
    @IBAction func sliceChart() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        let shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        self.shapeLayer = shapeLayer
        
        let radius: CGFloat = 80
        let sliceWidth: CGFloat = 48.0
        
        let value1: CGFloat = 35.0
        let value2: CGFloat = 45.0
        let value3: CGFloat = 20.0
        
        var startAngle = -CGFloat.pi * 0.5
        let valueCount = value1 + value2 + value3
        var endAngle = startAngle + (2 * .pi * value1) / valueCount
        
        /// add slice 1
        let sliceLayer1 = CAShapeLayer()
        let slicePath1 = UIBezierPath()
        slicePath1.addArc(withCenter: self.view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sliceLayer1.strokeColor = UIColor.systemYellow.cgColor
        sliceLayer1.fillColor = UIColor.clear.cgColor
        sliceLayer1.lineWidth = sliceWidth
        sliceLayer1.path = slicePath1.cgPath
        
        self.shapeLayer.addSublayer(sliceLayer1)
        
//        let ourLinedLayer1 = CAShapeLayer()
//        let outLinePath1 = UIBezierPath()
//        outLinePath1.addArc(withCenter: self.view.center, radius: radius  + sliceWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        outLinePath1.addArc(withCenter: self.view.center, radius: radius - sliceWidth / 2, startAngle: endAngle, endAngle: startAngle, clockwise: false)
//        outLinePath1.close()
//        outLinePath1.addClip()
//        ourLinedLayer1.strokeColor = UIColor.black.cgColor
//        ourLinedLayer1.lineWidth = 4.0
//        ourLinedLayer1.path = outLinePath1.cgPath
//        outLinePath1.lineJoinStyle = .round
//        ourLinedLayer1.lineCap = .round
//        ourLinedLayer1.lineJoin = .round
//        ourLinedLayer1.fillColor = UIColor.clear.cgColor
       

        let duration = 0.5
        var beginTime = 0.0
        
        self.animateSliceInPieChart(layer: sliceLayer1, beginTime: beginTime, duration: duration)
                
        beginTime += duration
        
        DispatchQueue.main.asyncAfter(deadline: .now()
            + beginTime) {
                startAngle = endAngle
                endAngle = startAngle + (2 * .pi * value2) / valueCount
                /// add slice 2
                let sliceLayer2 = CAShapeLayer()
                let slicePath2 = UIBezierPath()
                slicePath2.addArc(withCenter: self.view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                sliceLayer2.strokeColor = UIColor.systemBlue.cgColor
                sliceLayer2.fillColor = UIColor.clear.cgColor
                sliceLayer2.lineWidth = sliceWidth
                sliceLayer2.path = slicePath2.cgPath
                self.shapeLayer.addSublayer(sliceLayer2)
                self.animateSliceInPieChart(layer: sliceLayer2, beginTime: 0, duration: duration)
        }
        
        beginTime += duration
        
        DispatchQueue.main.asyncAfter(deadline: .now()
            + beginTime) {
                startAngle = endAngle
                endAngle = startAngle + (2 * .pi * value3) / valueCount
                /// add slice 3
                let sliceLayer3 = CAShapeLayer()
                let slicePath3 = UIBezierPath()
                slicePath3.addArc(withCenter: self.view.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                sliceLayer3.strokeColor = UIColor.systemPink.cgColor
                sliceLayer3.fillColor = UIColor.clear.cgColor
                sliceLayer3.lineWidth = sliceWidth
                sliceLayer3.path = slicePath3.cgPath
                self.shapeLayer.addSublayer(sliceLayer3)
                self.animateSliceInPieChart(layer: sliceLayer3, beginTime: 0, duration: duration)
               // self.shapeLayer.addSublayer(ourLinedLayer1)
        }
    }
    
    @IBAction func random() {
        
        self.shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        
        let lineWidth: CGFloat = 8.0
        let bigLinearWidth: CGFloat = 70.0
        let smallLinearWidth: CGFloat = 45.0
        
        let linearWidth: CGFloat = (bigLinearWidth * 2) + smallLinearWidth
        
        let startPoint = CGPoint.init(x: self.view.center.x - linearWidth/2, y: self.view.center.y - linearWidth/2)
        
        var arrPoints = [CGPoint]()
        // top left to top right direction
        var x: CGFloat = startPoint.x + bigLinearWidth
        var y: CGFloat = startPoint.y
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x += bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        // top right to bottom right direction
        y += bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y += bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        // bottom right to bottom left
        x -= bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x -= bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        // bottom left to top left direction
        
        y -= bigLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x += smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        x -= smallLinearWidth
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        y -= bigLinearWidth + (lineWidth / 2) // needed to merge the line
        arrPoints.append(CGPoint.init(x: x, y: y))
        
        let randomPath = UIBezierPath()
        
        // start drawing
        randomPath.move(to: startPoint)
        for point in arrPoints {
            randomPath.addLine(to: point)
        }
        shapeLayer.path = randomPath.cgPath
        shapeLayer.strokeColor = UIColor.systemTeal.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.animateSliceInPieChart(layer: shapeLayer, beginTime: 0, duration: 4.0)
    }
    
    @IBAction func plus() {
        
        shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.systemGreen.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        let bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = .round
        let radius: CGFloat = 30.0
        
        bezierPath.addArc(withCenter: self.view.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        
        let plusShape = CAShapeLayer()
        plusShape.fillColor = UIColor.clear.cgColor
        plusShape.strokeColor = UIColor.white.cgColor
        plusShape.lineCap = .round
        plusShape.lineWidth = radius / 10
        let linePath = UIBezierPath()
        
        let leftRightMargin: CGFloat = radius / 2
        
        let lineWidth = (2 * radius) - (2 * leftRightMargin)
        
        let centerPoint = self.view.center
        linePath.move(to: centerPoint)
        
        var x = centerPoint.x - lineWidth / 2
        var y = centerPoint.y
        
        linePath.move(to: CGPoint.init(x: x, y: y))
        linePath.addLine(to: CGPoint.init(x: x + lineWidth, y: y))
        
        x = centerPoint.x
        y = centerPoint.y - lineWidth / 2
        
        linePath.move(to: CGPoint.init(x: centerPoint.x, y: y))
        linePath.addLine(to: CGPoint.init(x: x , y: y + lineWidth))
        
        plusShape.path = linePath.cgPath
        
        shapeLayer.addSublayer(plusShape)
        
        animateSliceInPieChart(layer: plusShape, beginTime: 0, duration: 0.2)
    }
    
    @IBAction func minus() {
        
        shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.systemRed.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        let bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = .round
        let radius: CGFloat = 30.0
        
        bezierPath.addArc(withCenter: self.view.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        
        let minusShape = CAShapeLayer()
        minusShape.fillColor = UIColor.clear.cgColor
        minusShape.strokeColor = UIColor.white.cgColor
        minusShape.lineCap = .round
        minusShape.lineWidth = radius / 10
        let linePath = UIBezierPath()
        
        let leftRightMargin: CGFloat = radius / 2
        
        let lineWidth = (2 * radius) - (2 * leftRightMargin)
        
        let centerPoint = self.view.center
        linePath.move(to: centerPoint)
        
        let x = centerPoint.x - lineWidth / 2
        let y = centerPoint.y
        
        linePath.move(to: CGPoint.init(x: x, y: y))
        linePath.addLine(to: CGPoint.init(x: x + lineWidth, y: y))
        
        minusShape.path = linePath.cgPath
        
        shapeLayer.addSublayer(minusShape)
        
        animateSliceInPieChart(layer: minusShape, beginTime: 0, duration: 0.2)
    }
    
    @IBAction func close() {
        
        shapeLayer.removeFromSuperlayer()
        myView.removeFromSuperview()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.systemRed.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        let bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = .round
        let radius: CGFloat = 30.0
        
        bezierPath.addArc(withCenter: self.view.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        
        let crossShape = CAShapeLayer()
        crossShape.fillColor = UIColor.clear.cgColor
        crossShape.strokeColor = UIColor.white.cgColor
        crossShape.lineCap = .round
        crossShape.lineWidth = radius / 10
        let linePath = UIBezierPath()
        
        let leftRightMargin: CGFloat = radius / 2
        
        let lineWidth = (radius) - (3.5 * leftRightMargin)
        
        let centerPoint = self.view.center
        linePath.move(to: centerPoint)
        
        var x = centerPoint.x - lineWidth / 2
        var y = centerPoint.y - lineWidth / 2
        
        linePath.move(to: CGPoint.init(x: x, y: y))
        
        linePath.addLine(to: CGPoint.init(x: x + lineWidth, y: y + lineWidth))
        
        x = centerPoint.x + lineWidth / 2
        y = centerPoint.y - lineWidth / 2
        
        linePath.move(to: CGPoint.init(x: x, y: y))
        linePath.addLine(to: CGPoint.init(x: x - lineWidth, y: y + lineWidth))
        
        crossShape.path = linePath.cgPath
        
        shapeLayer.addSublayer(crossShape)
        
        animateSliceInPieChart(layer: crossShape, beginTime: 0, duration: 0.2)
    }
    
    @IBAction func tickMark() {
        
        myView.removeFromSuperview()
        shapeLayer.removeFromSuperlayer()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.systemGreen.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        let bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = .round
        let radius: CGFloat = 30.0
        
        bezierPath.addArc(withCenter: self.view.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        
        let tickShape = CAShapeLayer()
        tickShape.fillColor = UIColor.clear.cgColor
        tickShape.strokeColor = UIColor.white.cgColor
        tickShape.lineCap = .round
        tickShape.lineWidth = radius / 10
        
        let scale = (radius * 2) / 100
        let centerPoint = self.view.center
        let centerX = centerPoint.x
        let centerY = centerPoint.y
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: centerX - 25 * scale, y: centerY - 1 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX - 10 * scale, y: centerY + 15 * scale))
        checkmarkPath.addLine(to: CGPoint(x: centerX + 20.0 * scale, y: centerY - 15.0 * scale))
        
        tickShape.path = checkmarkPath.cgPath
        
        shapeLayer.addSublayer(tickShape)
        
        animateSliceInPieChart(layer: tickShape, beginTime: 0, duration: 0.2)
    }
    
    @IBAction func delete() {
        
        myView.removeFromSuperview()
        shapeLayer.removeFromSuperlayer()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(shapeLayer)
        
        let bezierPath = UIBezierPath()
        let radius: CGFloat = 30.0
        
        bezierPath.addArc(withCenter: self.view.center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        
        let marginP: CGFloat = 0.9
        
        let margin: CGFloat = radius * marginP
        
        let boxBottomMargin: CGFloat = margin * (1.0 - marginP)
        
        let gapBetweenBoxAndCap: CGFloat = (radius * 2) * 0.06
        
        // delete box
        let deleteBoxShape = CAShapeLayer()
        deleteBoxShape.fillColor = UIColor.white.cgColor
        deleteBoxShape.lineJoin = .round
        deleteBoxShape.lineCap = .round
        let boxWHP: CGFloat = 0.6 // 70 %
        let boxW = ( 2 * radius - margin ) * boxWHP
        let halfBoxWH = boxW * 0.5 // 70 %
        
        let topOriginY = self.view.center.y - (halfBoxWH) + 2 * gapBetweenBoxAndCap
        
        let boxTopLeft = CGPoint.init(x: self.view.center.x - halfBoxWH, y: topOriginY)
        let boxTopRight = CGPoint.init(x: boxTopLeft.x + boxW, y: boxTopLeft.y)
        let boxBottomRight = CGPoint.init(x: boxTopRight.x - boxBottomMargin, y: boxTopRight.y + boxW)
        let boxBottomLeft = CGPoint.init(x: boxTopRight.x - boxW + boxBottomMargin, y: boxBottomRight.y)
        
        let boxBezierPath = UIBezierPath()
        boxBezierPath.move(to: boxTopLeft)
        boxBezierPath.addLine(to: boxTopRight)
        boxBezierPath.addLine(to: boxBottomRight)
        boxBezierPath.addLine(to: boxBottomLeft)
        boxBezierPath.addLine(to: boxTopLeft)
        
        deleteBoxShape.path = boxBezierPath.cgPath
        
        shapeLayer.addSublayer(deleteBoxShape)
        
        // Box cap
        
        let boxCapLayer = CAShapeLayer()
        boxCapLayer.fillColor = UIColor.white.cgColor
        
        let xMaginBetweenBoxAndCap: CGFloat = radius / 10.0
        
        let capH = ((radius * 2) - boxW - gapBetweenBoxAndCap - xMaginBetweenBoxAndCap - boxBottomMargin) * 0.2
        
        let capW = boxW + (xMaginBetweenBoxAndCap * 2)
        
        let boxCapTopLeft = CGPoint.init(x: boxTopLeft.x - xMaginBetweenBoxAndCap, y: boxTopLeft.y - capH - gapBetweenBoxAndCap)
        let boxCapTopRight = CGPoint.init(x: boxCapTopLeft.x + capW, y: boxCapTopLeft.y)
        let boxCapBottomRight = CGPoint.init(x: boxCapTopRight.x, y: boxCapTopRight.y + capH)
        let boxCapBottomLeft = CGPoint.init(x: boxCapTopRight.x - capW, y: boxCapBottomRight.y)
        
        let boxCapPath = UIBezierPath()
        boxCapPath.move(to: boxCapTopLeft)
        boxCapPath.addLine(to: boxCapTopRight)
        boxCapPath.addLine(to: boxCapBottomRight)
        boxCapPath.addLine(to: boxCapBottomLeft)
        boxCapPath.addLine(to: boxCapTopLeft)
        
        boxCapLayer.path = boxCapPath.cgPath
        
        shapeLayer.addSublayer(boxCapLayer)
        
        // box top curve
        
        let boxCurveShape = CAShapeLayer()
        boxCurveShape.fillColor = UIColor.white.cgColor
        boxCurveShape.strokeColor = UIColor.clear.cgColor
        
        let curveOrigin = CGPoint.init(x: boxCapTopLeft.x + capW / 4, y: boxCapTopLeft.y - gapBetweenBoxAndCap)
        
        let curveWidth: CGFloat = capW - 2 * capW / 4
        
        let boxCurvePath = UIBezierPath(roundedRect: CGRect.init(origin: curveOrigin, size: CGSize.init(width: curveWidth, height: gapBetweenBoxAndCap)), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: gapBetweenBoxAndCap / 2.0, height: gapBetweenBoxAndCap / 2.0))
        
        boxCurveShape.path = boxCurvePath.cgPath
        shapeLayer.addSublayer(boxCurveShape)
    }
    
    @IBAction func drawComplexShape() {
        
        let width: CGFloat = 200
        let height: CGFloat = 300
        myView = UIView()
        myView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        myView.removeFromSuperview()
        myView.frame = CGRect.init(x: self.view.center.x - width / 2, y: self.view.center.y - height / 2, width: width, height: height)
        self.view.addSubview(myView)
        
        self.shapeLayer.removeFromSuperlayer()
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer.fillColor = UIColor.purple.cgColor
        self.shapeLayer.lineWidth = 5.0
        self.shapeLayer.strokeColor = UIColor.green.cgColor
        
        let radius: CGFloat = 40.0
        
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: radius, y: 0))
        
        path.addLine(to: CGPoint(x: myView.bounds.size.width/2 - radius, y: 0))
        path.addArc(withCenter: CGPoint(x: myView.bounds.size.width * 0.5, y: 0), radius: myView.bounds.size.width/6, startAngle: 0, endAngle: .pi, clockwise: true)
        path.move(to: CGPoint(x: myView.bounds.size.width/2 + myView.bounds.size.width/6, y: 0))
        path.addLine(to: CGPoint(x: myView.bounds.size.width/2 + myView.bounds.size.width/3, y: 0))
        path.move(to: path.currentPoint)
        print(path.currentPoint)
        path.addCurve(to:  CGPoint(x: myView.bounds.size.width, y: 100), controlPoint1:  CGPoint(x: myView.bounds.size.width + 50, y: 25), controlPoint2: CGPoint(x: myView.bounds.size.width - 100, y: 100))
        print(path.currentPoint)
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.move(to: CGPoint.init(x: 0, y: radius))
        path.move(to: CGPoint(x: 0, y: 200))
        path.addCurve(to: CGPoint.init(x: myView.bounds.size.width, y: myView.bounds.size.height), controlPoint1: CGPoint.init(x: myView.bounds.size.width + 50, y: path.currentPoint.y + 50), controlPoint2: CGPoint.init(x: path.currentPoint.x + 50, y: myView.bounds.size.height))
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y:  radius))
        path.move(to: CGPoint(x: radius, y: path.currentPoint.y))
        path.addArc(withCenter: path.currentPoint, radius: radius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        path.move(to: CGPoint(x: 0, y: height))
        let curveWidth: CGFloat = 100
        path.addCurve(to: CGPoint(x: curveWidth, y: height), controlPoint1: CGPoint(x: 1, y: 5), controlPoint2: CGPoint(x: 4, y: curveWidth))
        path.close()
        shapeLayer.path = path.cgPath
        myView.layer.addSublayer(shapeLayer)
        
        animateSliceInPieChart(layer: shapeLayer, beginTime: 0, duration: 5.0)
        
    }
}

extension ViewController {
    
    func animateSliceInPieChart(layer: CALayer, beginTime: Double, duration: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval(duration)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.beginTime = CACurrentMediaTime() + beginTime
        layer.add(animation, forKey: nil)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}

extension ViewController: CAAnimationDelegate {
    
    public func animationDidStart(_ anim: CAAnimation) {
        print("Animation started")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(flag)
        print("Animation stopped")
        myView.removeFromSuperview()
        shapeLayer.removeAllAnimations()
    }
}
