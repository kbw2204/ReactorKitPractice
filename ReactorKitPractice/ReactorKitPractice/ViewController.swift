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
        view.backgroundColor = .red
    }
}

