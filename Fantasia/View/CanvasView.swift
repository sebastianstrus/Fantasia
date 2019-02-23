//
//  Canvas.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation
import ColorSlider


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
    
    // MARK: - Public actions
    var backAction: (() -> Void)?
    var saveCanvasAction: (() -> Void)?
    
    // MARK: - Private variables
    fileprivate var strokeColor = AppColors.ACCENT_BLUE
    fileprivate var strokeWidth = kStrokeInitialWidth
    
    //temp:
    var audioPlayer: AVAudioPlayer?
    
    // MARK: - All subviews in main view
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background1")
        return iv
    }()
    
    fileprivate let safeAreaBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let bottomSafeAreaBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
        return view
    }()
    
    fileprivate let toolBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.DODGERBLUE
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
    
    fileprivate let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    fileprivate let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "button_save"), for: .normal)
        button.addTarget(self, action: #selector(handleSaveCanvas), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColors.WHITE_GRAY
        button.setImage(UIImage(named: "btn_undo"), for: .normal)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    fileprivate let titleTF: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Oswald-Medium", size: Device.IS_IPHONE ? 20 : 40)
        tf.textAlignment = .center
        tf.textColor = AppColors.WHITE_GRAY
        tf.attributedPlaceholder = NSAttributedString(string: "Enter title".localized, attributes: [NSAttributedString.Key.foregroundColor: AppColors.WHITE_GRAY])
        return tf
    }()
    
    fileprivate let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = AppColors.CRIMSON_RED
        button.setImage(UIImage(named: "btn_clear"), for: .normal)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    fileprivate var correctCanvasView: CorrectCanvasView = {
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
    
    fileprivate let widthSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = AppColors.WHITE_GRAY
        slider.minimumValue = kSliderMinValue
        slider.maximumValue = kSliderMaxValue
        slider.setValue(kSliderInitialValue, animated: false)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
       return slider
    }()
    
    fileprivate func setup() {
        backgroundColor = AppColors.WHITE_GRAY
        
        addSubview(backgroundImageView)
        backgroundImageView.pinToEdges(view: self, safe: false)
        
        addSubview(safeAreaBackground)
        safeAreaBackground.setAnchor(top: topAnchor,
                                     leading: leadingAnchor,
                                     bottom: nil,
                                     trailing: trailingAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0,
                                     width: 0,
                                     height: Device.IS_IPHONE ? 44 : 88)
        
        addSubview(navBarView)
        navBarView.setAnchor(top: safeTopAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: Device.IS_IPHONE ? 44 : 88)
        
        navBarView.addSubview(backButton)
        backButton.setAnchor(top: navBarView.topAnchor,
                             leading: navBarView.leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             paddingTop: 0,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: Device.IS_IPHONE ? 44 : 88,
                             height: Device.IS_IPHONE ? 44 : 88)
        
        navBarView.addSubview(saveButton)
        saveButton.setAnchor(top: navBarView.topAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: navBarView.trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: Device.IS_IPHONE ? 10 : 20,
                             width: Device.IS_IPHONE ? 44 : 88,
                             height: Device.IS_IPHONE ? 44 : 88)
        
        navBarView.addSubview(titleTF)
        titleTF.setAnchor(top: navBarView.topAnchor,
                          leading: backButton.trailingAnchor,
                          bottom: navBarView.bottomAnchor,
                          trailing: saveButton.leadingAnchor,
                          paddingTop: 0,
                          paddingLeft: Device.IS_IPHONE ? 20 : 40,
                          paddingBottom: 0,
                          paddingRight: Device.IS_IPHONE ? 20 : 40)
        
        addSubview(bottomSafeAreaBackground)
        bottomSafeAreaBackground.setAnchor(top: nil,
                                           leading: leadingAnchor,
                                           bottom: bottomAnchor,
                                           trailing: trailingAnchor,
                                           paddingTop: 0,
                                           paddingLeft: 0,
                                           paddingBottom: 0,
                                           paddingRight: 0,
                                           width: 0,
                                           height: Device.IS_IPHONE ? 50 : 100)
        
        addSubview(toolBarView)
        toolBarView.setAnchor(top: nil,
                              leading: leadingAnchor,
                              bottom: safeBottomAnchor,
                              trailing: trailingAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: Device.IS_IPHONE ? 96 : 192)
        
        toolBarView.addSubview(undoButton)
        undoButton.setAnchor(top: nil,
                             leading: toolBarView.leadingAnchor,
                             bottom: toolBarView.bottomAnchor,
                             trailing: nil,
                             paddingTop: 0,
                             paddingLeft: Device.IS_IPHONE ? 10 : 20,
                             paddingBottom: Device.IS_IPHONE ? 10 : 20,
                             paddingRight: 0,
                             width: Device.IS_IPHONE ? 44 : 88,
                             height: Device.IS_IPHONE ? 44 : 88)
        
        toolBarView.addSubview(clearButton)
        clearButton.setAnchor(top: nil,
                              leading: nil,
                              bottom: toolBarView.bottomAnchor,
                              trailing: toolBarView.trailingAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: Device.IS_IPHONE ? 10 : 20,
                              paddingRight: Device.IS_IPHONE ? 10 : 20,
                              width: Device.IS_IPHONE ? 44 : 88,
                              height: Device.IS_IPHONE ? 44 : 88)
        
        
        toolBarView.addSubview(widthSlider)
        widthSlider.setAnchor(top: nil,
                              leading: undoButton.trailingAnchor,
                              bottom: toolBarView.bottomAnchor,
                              trailing: clearButton.leadingAnchor,
                              paddingTop: 0,
                              paddingLeft: Device.IS_IPHONE ? 16 : 32,
                              paddingBottom: Device.IS_IPHONE ? 10 : 20,
                              paddingRight: Device.IS_IPHONE ? 16 : 32, width: 0, height: Device.IS_IPHONE ? 44 : 88)
        
        addSubview(correctCanvasView)
        correctCanvasView.setAnchor(top: navBarView.bottomAnchor,
                                    leading: leadingAnchor,
                                    bottom: toolBarView.topAnchor,
                                    trailing: trailingAnchor,
                                    paddingTop: Device.IS_IPHONE ? 10 : 20,
                                    paddingLeft: Device.IS_IPHONE ? 10 : 20,
                                    paddingBottom: Device.IS_IPHONE ? 10 : 20,
                                    paddingRight: Device.IS_IPHONE ? 10 : 20)
        
        addSubview(colorSlider)
        colorSlider.setAnchor(top: correctCanvasView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              paddingTop: Device.IS_IPHONE ? 18 : 36,
                              paddingLeft: Device.IS_IPHONE ? 22 : 44,
                              paddingBottom: 0,
                              paddingRight: Device.IS_IPHONE ? 22 : 44,
                              width: 0,
                              height: Device.IS_IPHONE ? 25 : 50)
        
        self.widthSlider.setThumbImage(self.progressImage(with: Device.IS_IPHONE ? 10 : 20), for: UIControl.State.normal)
        self.widthSlider.setThumbImage(self.progressImage(with: Device.IS_IPHONE ? 10 : 20), for: UIControl.State.selected)
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
        layer.frame = CGRect(x: 0, y: 0, width: Device.IS_IPHONE ? 30 : 60, height: Device.IS_IPHONE ? 30 : 60)
        layer.cornerRadius = Device.IS_IPHONE ? 15 : 30
        
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
    }
    
    // MARK: - public functions
    public func saveCanvas(){
        CanvasObjectController.shared.saveCanvasObject(image: correctCanvasView.asImage2(), title: titleTF.text ?? "No title", date: Date())
    }
    
    // todo: move
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
