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
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("show alert", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initConstraint()
    }

    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .systemBackground

        [decreaseButton, valueLabel, increaseButton, activityIndicator, alertButton].forEach {
            self.view.addSubview($0)
        }
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
            activityIndicator.topAnchor.constraint(equalTo: valueLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
        
        alertButton.rx.tap
            .map {Reactor.Action.showAlertAction}
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
        
        reactor.state.map{$0.isAlertShow}
            .compactMap {$0}
        .bind(onNext: {[weak self] in
            self?.showAlert("알람참", "개발자아라찌")
            }).disposed(by: disposeBag)
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "네에..", style: .default)
        alertViewController.addAction(okayAction)
        self.present(alertViewController, animated: true)
    }
}

