//
//  EKFormView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/15/18.
//

import UIKit

class EKTextFieldView: UIView {
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    var title: String {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text ?? ""
        }
    }
    
    var keyboardType: UIKeyboardType {
        set {
            textField.keyboardType = newValue
        }
        get {
            return textField.keyboardType
        }
    }
    
    var isSecure: Bool {
        set {
            textField.isSecureTextEntry = newValue
        }
        get {
            return textField.isSecureTextEntry
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupTitleLabel()
        setupTextField()
        addSeparatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = .gray
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.layout(.top, to: .bottom, of: titleLabel)
        textField.set(.height, of: 40)
        textField.layoutToSuperview(axis: .horizontally)
        textField.textColor = UIColor(white: 67/255, alpha: 1)
    }
    
    private func addSeparatorView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0.87, alpha: 1)
        addSubview(separatorView)
        separatorView.layout(.top, to: .bottom, of: textField)
        separatorView.set(.height, of: 0.5)
        separatorView.layoutToSuperview(.left, .right, .bottom)
    }
}

public class EKFormView: UIView {
    
    // MARK: Props
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private var textFieldViews: [EKTextFieldView] = []
    private var buttonBarView: EKButtonBarView!
    
    // MARK: Setup
    public init() {
        super.init(frame: UIScreen.main.bounds)
        set(.height, of: 300)
        setupScrollView()
        setupTitleLabel()
        setupFullNameView()
        setupEmailView()
        setupPasswordView()
        setupContinueButton()
        setupTapGestureRecognizer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, .width)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "Fill your personal details"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setupFullNameView() {
        let nameView = EKTextFieldView()
        scrollView.addSubview(nameView)
        nameView.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        nameView.layoutToSuperview(.left, .right, .width)
        nameView.title = "FULL NAME"
        nameView.keyboardType = .namePhonePad
        textFieldViews.append(nameView)
    }
    
    private func setupEmailView() {
        let emailView = EKTextFieldView()
        scrollView.addSubview(emailView)
        emailView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        emailView.layoutToSuperview(.left, .right, .width)
        emailView.title = "EMAIL ADDRESS"
        emailView.keyboardType = .emailAddress
        textFieldViews.append(emailView)
    }
    
    private func setupPasswordView() {
        let passwordView = EKTextFieldView()
        scrollView.addSubview(passwordView)
        passwordView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        passwordView.layoutToSuperview(.left, .right, .width)
        passwordView.title = "PASSWORD"
        passwordView.keyboardType = .phonePad
        passwordView.isSecure = true
        textFieldViews.append(passwordView)
    }
    
    private func setupContinueButton() {
        // Generate buttons content
        let buttonFont = UIFont.systemFont(ofSize: 16)
        
        // Close button - Just dismiss entry when the button is tapped
        let style = EKProperty.Label(font: buttonFont, color: .white)
        let closeButtonLabel = EKProperty.LabelContent(text: "Sign Up", style: style)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: UIColor(white: 0.8, alpha: 1)) {
            SwiftEntryKit.dismiss()
        }
        
        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, separatorColor: .clear, expandAnimatedly: true)
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
