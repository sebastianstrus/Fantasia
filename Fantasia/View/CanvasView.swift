//
//  Canvas.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation


fileprivate let kStrokeInitialWidth: CGFloat = 10
fileprivate let kSliderMinValue: Float = 1
fileprivate let kSliderMaxValue: Float = 20
fileprivate let kSliderInitialValue: Float = 10

class CanvasView: UIView {
    
    var changeColorAction: (() -> Void)?
    var backAction: (() -> Void)?
    var saveCanvasAction: (() -> Void)?
    
    //temp:
    var audioPlayer: AVAudioPlayer?
    
    fileprivate var strokeColor = AppColors.ACCENT_BLUE
    fileprivate var strokeWidth = kStrokeInitialWidth
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColors.ACCENT_BLUE
        button.setImage(UIImage(named: "btn_undo"), for: .normal)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    let titleTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter title".localized
        tf.font = UIFont(name: "Oswald-Medium", size: 20)
        tf.textAlignment = .center
        return tf
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.red
        button.setImage(UIImage(named: "btn_clear"), for: .normal)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    var correctCanvasView: CorrectCanvasView = {
        let view = CorrectCanvasView()
        view.setShadow()
        return view
    }()
    
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
        playSound()
    }
    
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
        button.backgroundColor = AppColors.ACCENT_BLUE
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "button_save"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSaveCanvas), for: .touchUpInside)
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
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(backButton)
        backButton.setAnchor(top: safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        
        addSubview(saveButton)
        saveButton.setAnchor(top: safeTopAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 30, height: 30)
        
        addSubview(titleTF)
        titleTF.setAnchor(top: safeTopAnchor, leading: backButton.trailingAnchor, bottom: backButton.bottomAnchor, trailing: saveButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        addSubview(undoButton)
        undoButton.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 30, height: 30)
        
        addSubview(clearButton)
        clearButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 30, height: 30)
        
        addSubview(colorButton)
        colorButton.setAnchor(top: nil, leading: undoButton.trailingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 10, paddingRight: 0, width: 30, height: 30)
        
        
        addSubview(widthSlider)
        widthSlider.setAnchor(top: nil, leading: colorButton.trailingAnchor, bottom: bottomAnchor, trailing: clearButton.leadingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 10, paddingRight: 10)
        
        addSubview(correctCanvasView)
        correctCanvasView.setAnchor(top: titleTF.bottomAnchor, leading: leadingAnchor, bottom: widthSlider.topAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
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
        widthSlider.setLightShadow()
    }
    
    @objc fileprivate func handleChangeColor() {
        changeColorAction?()
    }
    
    @objc fileprivate func handleBack() {
        backAction?()
    }
    
    @objc fileprivate func handleSaveCanvas() {
        saveCanvasAction?()
    }
    
    
    
    //public functions
    public func setColor(color: UIColor){
        correctCanvasView.setStrokeColor(color: color)
        colorButton.layer.backgroundColor = color.cgColor
    }
    
    
    public func saveCanvas(){
        CanvasObjectController.shared.saveCanvasObject(image: correctCanvasView.asImage2(), title: titleTF.text ?? "No title", date: Date())
    }
    
    func playSound() {
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying { audioPlayer.stop() }
        
        guard let soundURL = Bundle.main.url(forResource: "page_flip", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch let error {
            print(error)
        }
    }
}
