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
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupTitleLabel()
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top)
        titleLabel.layoutToSuperview(axis: .horizontally)
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.layout(.top, to: .bottom, of: titleLabel, offset: 10)
        textField.layoutToSuperview(axis: .horizontally)
        textField.layoutToSuperview(.bottom)
    }
}

public class EKFormView: UIView {
    
    // MARK: Props
    private let titleLabel = UILabel()
    private let fullNameView = EKTextFieldView()
    private let emailView = EKTextFieldView()
    private let passwordView = EKTextFieldView()
    private let continueButton = UIButton()
    
    // MARK: Setup
    public init() {
        super.init(frame: UIScreen.main.bounds)
        setupTitleLabel()
        setupFullNameView()
        setupEmailView()
        setupPasswordView()
        setupContinueButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, offset: 20)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "This is a form"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setupFullNameView() {
        addSubview(fullNameView)
        fullNameView.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        fullNameView.layoutToSuperview(axis: .horizontally, offset: 30)
    }
    
    private func setupEmailView() {
        addSubview(emailView)
        emailView.layout(.top, to: .bottom, of: fullNameView, offset: 20)
        emailView.layoutToSuperview(axis: .horizontally, offset: 30)
    }
    
    private func setupPasswordView() {
        addSubview(passwordView)
        passwordView.layout(.top, to: .bottom, of: emailView, offset: 20)
        passwordView.layoutToSuperview(axis: .horizontally, offset: 30)
        passwordView.layoutToSuperview(.bottom)
    }
    
    private func setupContinueButton() {
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
