//
//  ResultView.swift
//  BMI Calculator
//
//  Created by Ilyas Tyumenev on 03.08.2023.
//

import UIKit
import SnapKit

protocol ResultViewDelegate: AnyObject {
    func resultView(_ view: ResultView, recalculateButtonPressed button: UIButton)
}

class ResultView: UIView {
    
    // MARK: - Properties
    weak var delegate: ResultViewDelegate?
        
    private let yourResultLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bmiLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 80)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let adviceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        [self.yourResultLabel,
         self.bmiLabel,
         self.adviceLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    lazy var recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("RECALCULATE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(recalculateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        addSubview(stackView)
        addSubview(recalculateButton)
    }
    
    private func addConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        yourResultLabel.snp.makeConstraints { make in
        }
        
        bmiLabel.snp.makeConstraints { make in
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        recalculateButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(51)
        }
    }
}

// MARK: - Target Actions
private extension ResultView {
    
    @objc func recalculateButtonPressed(_ button: UIButton) {
        delegate?.resultView(self, recalculateButtonPressed: button)
    }
}
