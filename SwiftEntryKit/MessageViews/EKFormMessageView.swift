//
//  EKFormMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/15/18.
//

import UIKit

public class EKFormMessageView: UIView {
    
    // MARK: Props
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private var textFieldViews: [EKTextField] = []
    private var buttonBarView: EKButtonBarView!
    
    // MARK: Setup
    public init(with title: EKProperty.LabelContent, textFieldsContent: [EKProperty.TextFieldContent], buttonContent: EKProperty.ButtonContent) {
        super.init(frame: UIScreen.main.bounds)
        set(.height, of: 280, priority: .defaultHigh)
        setupScrollView()
        setupTitleLabel(with: title)
        setupTextFields(with: textFieldsContent)
        setupButton(with: buttonContent)
        setupTapGestureRecognizer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFields(with textFieldsContent: [EKProperty.TextFieldContent]) {
        textFieldViews = textFieldsContent.map { content -> EKTextField in
            let textField = EKTextField(with: content)
            scrollView.addSubview(textField)
            return textField
        }
        
        textFieldViews.first!.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        textFieldViews.spread(.vertically, offset: 5)
        textFieldViews.layoutToSuperview(axis: .horizontally)
    }
    
    // Setup tap gesture
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.layoutToSuperview(axis: .horizontally, offset: 20)
        scrollView.layoutToSuperview(axis: .vertically, offset: 20)
        scrollView.layoutToSuperview(.width, .height, offset: -40)
    }
    
    private func setupTitleLabel(with title: EKProperty.LabelContent) {
        scrollView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, .width)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Fill your personal details"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setupButton(with buttonContent: EKProperty.ButtonContent) {
        let buttonsBarContent = EKProperty.ButtonBarContent(with: buttonContent, separatorColor: .clear, expandAnimatedly: true)
        buttonBarView = EKButtonBarView(with: buttonsBarContent)
        buttonBarView.clipsToBounds = true
        scrollView.addSubview(buttonBarView)
        buttonBarView.expand()
        buttonBarView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        buttonBarView.layoutToSuperview(.centerX)
        buttonBarView.layoutToSuperview(.width, offset: -40)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layer.cornerRadius = 5
    }
    
    // Tap Gesture
    @objc func tapGestureRecognized() {
        endEditing(true)
    }
}
