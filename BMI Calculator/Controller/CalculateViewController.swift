//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Ilyas Tyumenev on 15.04.2023.
//

import UIKit

class CalculateViewController: UIViewController {

    // MARK: - Properties
    private let calculateBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calculate_background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let calculateView = CalculateView()
    var calculatorBrain = CalculatorBrain()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateView.delegate = self
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.addSubview(calculateBackgroundImageView)
        view.addSubview(calculateView)
    }
    
    private func setupConstraints() {
        calculateBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        calculateView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - CalculateViewDelegate
extension CalculateViewController: CalculateViewDelegate {
    
    func calculateView(_ view: CalculateView, heightSliderChanged sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        calculateView.heightValueLabel.text = "\(height)m"
    }
    
    func calculateView(_ view: CalculateView, weightSliderChanged sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        calculateView.weightValueLabel.text = "\(weight)kg"
    }
    
    func calculateView(_ view: CalculateView, calculateButtonPressed button: UIButton) {
        let height = calculateView.heightSlider.value
        let weight = calculateView.weightSlider.value
        calculatorBrain.calculateBMI(height: height, weight: weight)

        let resultVC = ResultViewController()
        resultVC.bmiValue = calculatorBrain.getBMIValue()
        resultVC.advice = calculatorBrain.getAdvice()
        resultVC.color = calculatorBrain.getColor()
        resultVC.modalPresentationStyle = .automatic
        self.present(resultVC, animated: true)
    }
}
