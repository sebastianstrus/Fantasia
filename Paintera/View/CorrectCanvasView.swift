//
//  CorrectCanvasView.swift
//  Paintera
//
//  Created by Sebastian Strus on 2019-02-10.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

let kCorrectStrokeInitialWidth: CGFloat = 10
let kCorrectInitialColor = UIColor.red
let kCorrectSliderMinValue: Float = 1
let kCorrectSliderMaxValue: Float = 20
let kCorrectSliderInitialValue: Float = 10

class CorrectCanvasView: UIView {
    
    fileprivate var lines = [Line]()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public actions
    fileprivate var changeColorAction: (() -> Void)?
    fileprivate var strokeColor = kCorrectInitialColor
    fileprivate var strokeWidth = kCorrectStrokeInitialWidth
    
    // MARK: - Override functions
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineCap(CGLineCap.round)
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor,
                               width: strokeWidth,
                               points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    // MARK: - Private functions
    fileprivate func setup() {
        backgroundColor = UIColor.white
    }
    
    
    // MARK: - Public functions
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
}
