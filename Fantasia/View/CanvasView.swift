//
//  Canvas.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit


let kStrokeInitialWidth: CGFloat = 10
let kInitialColor = UIColor.orange
let kSliderMinValue: Float = 1
let kSliderMaxValue: Float = 20
let kSliderInitialValue: Float = 10

class CanvasView: UIView {
    
    var changeColorAction: (() -> Void)?
    
    fileprivate var strokeColor = kInitialColor
    fileprivate var strokeWidth = kStrokeInitialWidth
    
    
    let widthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = kSliderMinValue
        slider.maximumValue = kSliderMaxValue
        slider.setValue(kSliderInitialValue, animated: false)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
       return slider
    }()
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 0, g: 122, b: 255).cgColor
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let widthLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont(name: "LuckiestGuy-Regular", size: 20)
        return label
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
        colorButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 44, height: 44)
        
        addSubview(widthSlider)
        widthSlider.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: colorButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 44)
        
        addSubview(widthLabel)
        widthLabel.setAnchor(top: nil, leading: leadingAnchor, bottom: widthSlider.topAnchor, trailing: colorButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 44, height: 44)
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
    
    @objc fileprivate func handleSliderChange() {
        strokeWidth = CGFloat(widthSlider.value)
        widthLabel.text = "\(Int(widthSlider.value))"
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
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
        colorButton.layer.backgroundColor = color.cgColor
    }
    
    func setStrokeWidth(width: CGFloat) {
        strokeWidth = width
        widthLabel.text = "\(width)"
    }
}
