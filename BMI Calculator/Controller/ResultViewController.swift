//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Ilyas Tyumenev on 15.04.2023.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {

    // MARK: - Properties
    private let resultBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "result_background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    private let resultView = ResultView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()        
        resultView.delegate = self
        resultView.bmiLabel.text = bmiValue
        resultView.adviceLabel.text = advice
        view.backgroundColor = color
        
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.addSubview(resultBackgroundImageView)
        view.addSubview(resultView)
    }
    
    private func setupConstraints() {        
        resultBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leadingMargin)
            make.trailing.equalTo(view.snp.trailingMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - CalculateViewDelegate
extension ResultViewController: ResultViewDelegate {
    
    func resultView(_ view: ResultView, recalculateButtonPressed button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
