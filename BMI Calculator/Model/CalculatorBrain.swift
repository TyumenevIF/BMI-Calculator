//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Ilyas Tyumenev on 16.04.2023.
//

import Foundation
import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue,
                      advice: "Eat more pies", color:
                        #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            )
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue,
                      advice: "Fit as a fiddle",
                      color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            )
        } else {
            bmi = BMI(value: bmiValue,
                      advice: "Fit as a fiddle",
                      color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            )
        }
    }
}
