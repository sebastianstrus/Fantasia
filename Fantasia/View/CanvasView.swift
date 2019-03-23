//
//  CanvasView.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import ColorSlider
import SwiftySound


fileprivate let kStrokeInitialWidth: CGFloat = 10
fileprivate let kSliderMinValue: Float = 1
fileprivate let kSliderMaxValue: Float = 20
fileprivate let kSliderInitialValue: Float = 10

class CanvasView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private variables
    fileprivate var strokeColor = AppColors.TRANSPARENT_BLACK
    fileprivate var strokeWidth = kStrokeInitialWidth
        
    // MARK: - All subviews in main view
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background1")
        return iv
    }()
    
    fileprivate let toolBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let toolsContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColors.WHITE_GRAY
        button.setImage(UIImage(named: "btn_undo"), for: .normal)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New canvas"
        label.textAlignment = .center
        label.textColor = AppColors.WHITE_GRAY
        label.font = UIFont(name: "Oswald-Medium", size: Device.IS_IPHONE ? 20 : 40)
        return label
    }()
    
    fileprivate let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColors.CRIMSON_RED
        button.setImage(UIImage(named: "btn_clear"), for: .normal)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    // Workaround, adds shadow which doesn't desappear on clear-animation
    fileprivate var correctCanvasViewShadow: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.setShadow()
        return view
    }()
    
    var correctCanvasView: CorrectCanvasView = {
        let view = CorrectCanvasView()
        return view
    }()
    
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    fileprivate let widthSliderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate let widthSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = AppColors.WHITE_GRAY
        slider.minimumValue = kSliderMinValue
        slider.maximumValue = kSliderMaxValue
        slider.setValue(kSliderInitialValue, animated: false)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
       return slider
    }()
    
    fileprivate let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    fileprivate let colorSlider: ColorSlider = {
        let slider = ColorSlider(orientation: .horizontal, previewSide: .top)
        slider.addTarget(self, action: #selector(handleColorChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleColorChange(_ slider: ColorSlider) {
        correctCanvasView.setStrokeColor(color: slider.color)
    }
    
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(correctCanvasViewShadow)
        correctCanvasViewShadow.setAnchor(top: safeTopAnchor,
                                          leading: leadingAnchor,
                                          bottom: safeBottomAnchor,
                                          trailing: trailingAnchor,
                                          paddingTop: Device.IS_IPHONE ? 10 : 20,
                                          paddingLeft: Device.IS_IPHONE ? 10 : 20,
                                          paddingBottom: Device.IS_IPHONE ? 60 : 70,
                                          paddingRight: Device.IS_IPHONE ? 10 : 20)
        
        correctCanvasViewShadow.addSubview(correctCanvasView)
        correctCanvasView.pinToEdges(view: correctCanvasViewShadow, safe: false)
        
        addSubview(toolBarView)
        toolBarView.setAnchor(top: safeBottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              paddingTop: -50,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0)
        
        toolBarView.addSubview(toolsContainer)
        toolsContainer.setAnchor(top: toolBarView.topAnchor,
                              leading: toolBarView.leadingAnchor,
                              bottom: nil,
                              trailing: toolBarView.trailingAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 50)
        
        toolsContainer.addSubview(undoButton)
        undoButton.setAnchor(top: nil,
                             leading: toolsContainer.leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             paddingTop: 0,
                             paddingLeft: Device.IS_IPHONE ? 10 : 20,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 44,
                             height: 44)
        undoButton.centerYAnchor.constraint(equalTo: toolsContainer.centerYAnchor).isActive = true
        
        toolsContainer.addSubview(clearButton)
        clearButton.setAnchor(top: nil,
                              leading: nil,
                              bottom: nil,
                              trailing: toolsContainer.trailingAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: Device.IS_IPHONE ? 10 : 20,
                              width: 44,
                              height: 44)
        clearButton.centerYAnchor.constraint(equalTo: toolsContainer.centerYAnchor).isActive = true
        
        let slidersStackView = createHorizontalStackView(views: [widthSliderContainer, colorSlider],
                                                       spacing: 20)
        
        widthSliderContainer.addSubview(widthSlider)
        widthSlider.pinToEdges(view: widthSliderContainer, safe: false)
        
        toolsContainer.addSubview(slidersStackView)
        slidersStackView.setAnchor(top: toolsContainer.topAnchor,
                              leading: undoButton.trailingAnchor,
                              bottom: toolsContainer.bottomAnchor,
                              trailing: clearButton.leadingAnchor,
                              paddingTop: 10,
                              paddingLeft: 8,
                              paddingBottom: 10,
                              paddingRight: 8,
                              width: 0,
                              height: 30)
        
        self.widthSlider.setThumbImage(self.progressImage(with: 10), for: UIControl.State.normal)
        self.widthSlider.setThumbImage(self.progressImage(with: 10), for: UIControl.State.selected)
        widthSlider.setLightShadow()
    }
    
    let minColor : UIImage = {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }()
    
    func progressImage(with progress : Float) -> UIImage {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        layer.cornerRadius = 15
        
        let label = UILabel(frame: layer.frame)
        label.text = "\(Int(progress))"
        label.font = AppFonts.SLIDER_FONT
        label.textColor = UIColor.darkGray
        layer.addSublayer(label.layer)
        label.textAlignment = .center
        label.tag = 100
        
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    @objc fileprivate func handleSliderChange() {
        strokeWidth = CGFloat(widthSlider.value)
        correctCanvasView.setStrokeWidth(width: strokeWidth)
        
        self.widthSlider.setThumbImage(self.progressImage(with: self.widthSlider.value), for: UIControl.State.normal)
        self.widthSlider.setThumbImage(self.progressImage(with: self.widthSlider.value), for: UIControl.State.selected)
    }
    
    @objc fileprivate func handleUndo() {
        correctCanvasView.undo()
    }
    
    @objc fileprivate func handleClear() {
        
        UIView.transition(with:correctCanvasView,
                          duration:0.8,
                          options: .transitionCurlUp,
                          animations: { self.correctCanvasView = self.correctCanvasView },
                          completion: nil)
        correctCanvasView.clear()
        Sound.play(file: "page_flip.mp3")
        
    }
    
    func setCanvas(canvas: CanvasObject) {
        titleLabel.text = canvas.title
        let image = ImageController.shared.fetchImage(imageName: (canvas.imageName)!)!
        setImage(image: image)
    }
    
    public func setImage(image: UIImage) {
        let temImageView = UIImageView(frame: correctCanvasView.frame)
        temImageView.contentMode = .scaleAspectFill
        temImageView.image = image
        let correctImage = temImageView.asImage()
        correctCanvasView.backgroundColor = UIColor(patternImage: correctImage)
    }
}
