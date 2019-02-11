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
    var menuAction: (() -> Void)?
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
    
    let correctCanvasView: CorrectCanvasView = {
        let view = CorrectCanvasView()
        view.setShadow()
        return view
    }()
    
    @objc fileprivate func handleUndo() {
        correctCanvasView.undo()
    }
    
    @objc fileprivate func handleClear() {
        playSound()
        UIView.transition(from: correctCanvasView, to: correctCanvasView, duration: 0.5, options: [.transitionCurlUp, .showHideTransitionViews])
        correctCanvasView.clear()
    }
    
    let widthLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont(name: "LuckiestGuy-Regular", size: 20)
        return label
    }()
    
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
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 0, g: 122, b: 255).cgColor
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Menu", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: AppColors.ACCENT_BLUE]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.borderColor = UIColor(r: 0, g: 122, b: 255).cgColor
        button.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: AppColors.ACCENT_BLUE]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.borderColor = UIColor(r: 0, g: 122, b: 255).cgColor
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
        
        addSubview(undoButton)
        undoButton.setAnchor(top: safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        addSubview(clearButton)
        clearButton.setAnchor(top: safeTopAnchor, leading: nil, bottom: nil, trailing: safeTrailingAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 40, height: 40)
        
        addSubview(titleTF)
        titleTF.setAnchor(top: safeTopAnchor, leading: undoButton.trailingAnchor, bottom: undoButton.bottomAnchor, trailing: clearButton.leadingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        addSubview(backButton)
        backButton.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 30, paddingRight: 10, width: CGFloat(Device.SCREEN_WIDTH - 60) / 2, height: 44)
        
        addSubview(saveButton)
        saveButton.setAnchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 30, paddingRight: 20, width: CGFloat(Device.SCREEN_WIDTH - 60) / 2, height: 44)
        
        addSubview(widthLabel)
        widthLabel.setAnchor(top: nil, leading: leadingAnchor, bottom: saveButton.topAnchor, trailing: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 44, height: 44)
        
        addSubview(colorButton)
        colorButton.setAnchor(top: nil, leading: nil, bottom: saveButton.topAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 20, width: 44, height: 44)
        
        addSubview(widthSlider)
        widthSlider.setAnchor(top: widthLabel.topAnchor, leading: widthLabel.trailingAnchor, bottom: saveButton.topAnchor, trailing: colorButton.leadingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 20)
        
        addSubview(correctCanvasView)
        correctCanvasView.setAnchor(top: titleTF.bottomAnchor, leading: leadingAnchor, bottom: widthSlider.topAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    @objc fileprivate func handleSliderChange() {
        strokeWidth = CGFloat(widthSlider.value)
        correctCanvasView.setStrokeWidth(width: strokeWidth)
        widthLabel.text = "\(Int(widthSlider.value))"
    }
    
    @objc fileprivate func handleChangeColor() {
        changeColorAction?()
    }
    
    @objc fileprivate func handleMenu() {
        menuAction?()
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
