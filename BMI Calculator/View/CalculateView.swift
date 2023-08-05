//
//  CalculateView.swift
//  BMI Calculator
//
//  Created by Ilyas Tyumenev on 03.08.2023.
//

import UIKit
import SnapKit

protocol CalculateViewDelegate: AnyObject {
    func calculateView(_ view: CalculateView, heightSliderChanged sender: UISlider)
    func calculateView(_ view: CalculateView, weightSliderChanged sender: UISlider)
    func calculateView(_ view: CalculateView, calculateButtonPressed button: UIButton)
}

class CalculateView: UIView {
    
    // MARK: - Properties
    weak var delegate: CalculateViewDelegate?
    
    private let calculateYourBmiLabel: UILabel = {
        let label = UILabel()
        label.text = "CALCULATE YOUR BMI"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1.5m"
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var heightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 0
        [self.heightLabel,
         self.heightValueLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    let heightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 3.0
        slider.value = 1.5
        slider.minimumTrackTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.52)
        slider.thumbTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.50)
        slider.addTarget(self, action: #selector(heightSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "100Kg"
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 0
        [self.weightLabel,
         self.weightValueLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    let weightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 200
        slider.value = 100
        slider.minimumTrackTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.52)
        slider.thumbTintColor = UIColor(red: 116/255, green: 114/255, blue: 210/255, alpha: 0.50)
        slider.addTarget(self, action: #selector(weightSliderChanged), for: .valueChanged)
        return slider
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALCULATE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor(red: 98/255, green: 96/255, blue: 157/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        [self.calculateYourBmiLabel,
         self.heightStackView,
         self.heightSlider,
         self.weightStackView,
         self.weightSlider,
         self.calculateButton].forEach { stack.addArrangedSubview($0) }
        return stack
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
        addSubview(mainStackView)
    }
    
    private func addConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        calculateYourBmiLabel.snp.makeConstraints { make in
        }
        
        heightStackView.snp.makeConstraints { (make) in
            make.height.equalTo(21)
        }
        
        heightLabel.snp.makeConstraints { make in
        }
        
        heightValueLabel.snp.makeConstraints { make in
        }
        
        heightSlider.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        weightStackView.snp.makeConstraints { (make) in
            make.height.equalTo(21)
        }
        
        weightLabel.snp.makeConstraints { make in
        }
        
        weightValueLabel.snp.makeConstraints { make in
        }
        
        weightSlider.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.height.equalTo(51)
        }
    }
}

// MARK: - Target Actions
private extension CalculateView {
    
    @objc func heightSliderChanged(_ sender: UISlider) {
        delegate?.calculateView(self, heightSliderChanged: sender)
    }
    
    @objc func weightSliderChanged(_ sender: UISlider) {
        delegate?.calculateView(self, weightSliderChanged: sender)
    }
    
    @objc func calculateButtonPressed(_ button: UIButton) {
        delegate?.calculateView(self, calculateButtonPressed: button)
    }
}
