//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by 강병우 on 2020/07/06.
//  Copyright © 2020 강병우. All rights reserved.
// View는 View이기 때문에 비즈니스 로직이 없어야함. 단 bind를 해줌

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    typealias Reactor = ViewReactor
    
    // MARK: - Init
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    let decreaseButton: UIButton = {
       let decreaseButton = UIButton()
        decreaseButton.setImage(UIImage(systemName: "minus"), for: .normal)
        decreaseButton.tintColor = .black
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        return decreaseButton
    }()
    
    let increaseButton: UIButton = {
        let increaseButton = UIButton()
        increaseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        increaseButton.tintColor = .black
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        return increaseButton
    }()
    
    let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = "0"
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        return valueLabel
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let statusIndicator = UIActivityIndicatorView()
        statusIndicator.translatesAutoresizingMaskIntoConstraints  = false
        return statusIndicator
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .systemBackground

        [decreaseButton, valueLabel, increaseButton, activityIndicator].forEach{
            self.view.addSubview($0)
        }
        
        initConstraint()
    }
    
    func initConstraint() {
        NSLayoutConstraint.activate([
            decreaseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            decreaseButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            decreaseButton.heightAnchor.constraint(equalTo: decreaseButton.widthAnchor),
            
            valueLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            increaseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            increaseButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            increaseButton.heightAnchor.constraint(equalTo: increaseButton.widthAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: valueLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    func bind(reactor: ViewReactor) {
        
        // action
        decreaseButton.rx.tap
            .map{Reactor.Action.decrease}
            .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        increaseButton.rx.tap
            .map{Reactor.Action.increase}
            .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // State
        reactor.state.map{$0.value}
        .distinctUntilChanged()
        .map{String($0)}
            .bind(to: valueLabel.rx.text)
        .disposed(by: disposeBag)
        
        reactor.state.map{$0.isLoading}
        .distinctUntilChanged()
            .bind(to: activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
}

