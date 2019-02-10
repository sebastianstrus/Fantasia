//
//  CorrectCanvasView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit


let kCorrectStrokeInitialWidth: CGFloat = 10
let kCorrectInitialColor = AppColors.ACCENT_BLUE
let kCorrectSliderMinValue: Float = 1
let kCorrectSliderMaxValue: Float = 20
let kCorrectSliderInitialValue: Float = 10

class CorrectCanvasView: UIView {
    
    var changeColorAction: (() -> Void)?
    
    fileprivate var strokeColor = kCorrectInitialColor
    fileprivate var strokeWidth = kCorrectStrokeInitialWidth
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        //custom drawing
        
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineCap(.butt)
        
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.width)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }
                else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    fileprivate var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, width: strokeWidth, points: []))
    }
    
    // handle screen touching
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
//    @objc fileprivate func handleSliderChange() {
//        strokeWidth = CGFloat(widthSlider.value)
//        widthLabel.text = "\(Int(widthSlider.value))"
//    }
//
//    @objc func handleChangeColor() {
//        changeColorAction?()
//    }
    
    // public functions
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    func setStrokeWidth(width: CGFloat) {
        strokeWidth = width
    }
    
    func saveCanvas() {
        
    }
}