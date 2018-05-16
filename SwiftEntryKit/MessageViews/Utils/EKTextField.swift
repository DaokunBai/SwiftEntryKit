//
//  EKTextField.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/16/18.
//

import Foundation
import UIKit

public class EKTextField: UIView {
    
    private let content: EKProperty.TextFieldContent
    
    private let imageView = UIImageView()
    private let textField = UITextField()
    
    init(with content: EKProperty.TextFieldContent) {
        self.content = content
        super.init(frame: UIScreen.main.bounds)
        setupImageView()
        setupTextField()
        setupSeparatorView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.contentMode = .center
        imageView.set(.width, .height, of: 45)
        imageView.layoutToSuperview(.leading)
        imageView.image = content.leadingImage
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.textFieldContent = content
        textField.set(.height, of: 45)
        textField.layout(.leading, to: .trailing, of: imageView)
        textField.layoutToSuperview(.top, .trailing)
        
        imageView.layout(to: .centerY, of: textField)
    }
    
    private func setupSeparatorView() {
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.backgroundColor = content.bottomBorderColor
        separatorView.layout(.top, to: .bottom, of: textField)
        separatorView.set(.height, of: 1)
        separatorView.layoutToSuperview(.bottom)
        separatorView.layoutToSuperview(axis: .horizontally, offset: 10)
    }
}
