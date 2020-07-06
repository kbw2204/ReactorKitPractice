//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by 강병우 on 2020/07/06.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    // MARK: - Property
    weak var decreaseButton: UIButton?
    weak var increaseButton: UIButton?
    weak var valueLabel: UILabel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .systemBackground
        
        let decreaseButton = UIButton()
        self.decreaseButton = decreaseButton
        decreaseButton.setImage(UIImage(systemName: "minus"), for: .normal)
        decreaseButton.tintColor = .black
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(decreaseButton)
        
        NSLayoutConstraint.activate([
            decreaseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            decreaseButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            decreaseButton.heightAnchor.constraint(equalTo: decreaseButton.widthAnchor)
        ])
        
        let valueLabel = UILabel()
        self.valueLabel = valueLabel
        valueLabel.text = "0"
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        let increaseButton = UIButton()
        self.increaseButton = increaseButton
        increaseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        increaseButton.tintColor = .black
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(increaseButton)
        
        NSLayoutConstraint.activate([
            increaseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            increaseButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            increaseButton.heightAnchor.constraint(equalTo: increaseButton.widthAnchor)
        ])
    }
}

