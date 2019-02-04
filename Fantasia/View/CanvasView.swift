//
//  Canvas.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var changeColorAction: (() -> Void)?
    
    fileprivate var strokeColor = UIColor.blue
    fileprivate var strokeWidth: CGFloat = 5
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor.white
        
        addSubview(colorButton)
        colorButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 40, height: 40)
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
    
    @objc func handleChangeColor() {
        changeColorAction?()
    }
    
    // public functions
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setColor(color: UIColor) {
        strokeColor = color
        colorButton.layer.backgroundColor = color.cgColor
    }
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
        colorButton.layer.backgroundColor = color.cgColor
    }
}
