//
//  ViewController.swift
//  2paraStyleRu
//
//  Created by Ирина Улитина on 01/10/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    let undefConstant : Double = 1e300
    let clearText = "C"
    var currentNumber : Double = 0
    var rememberedNumber: Double = 0
    var performMath: Bool = false
    var operation: String = ""
    var isAfterEquality: Bool = false
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var emptyButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var digitsButton: [UIButton]!
    @IBOutlet var operationButton: [UIButton]!
    
    fileprivate func correct() {
        if currentNumber - Double(Int(currentNumber)) == 0 {
            let temp = Int(currentNumber)
            label.text = String(temp)
        } else {
            label.text = String(currentNumber)
        }
    }
    
    @objc func handleDigitTapping(_ sender : UIButton) {
        if isAfterEquality && !(label.text?.isEmpty)! {
            print(sender.currentTitle!)
            currentNumber = Double(sender.currentTitle!)!
            rememberedNumber = 0
            correct()
        }
        else if performMath {
            isAfterEquality = false

            label.text = sender.currentTitle
            currentNumber = Double(label.text!)!
            performMath = false
        } else {
            isAfterEquality = false

            if let text = sender.currentTitle {
                //label.text! += text
                
                currentNumber *= 10
                currentNumber += Double(text)!
                correct()
            }
        }
    }
    
    @objc func handleOpearation(_ sender : UIButton) {
        guard let text = sender.currentTitle else { return }
        if text != "=" && text != "," && text != "C" {
            if isAfterEquality {
                isAfterEquality = false
            }
            if (rememberedNumber != undefConstant) {
                if operation == "+" {
                    currentNumber = currentNumber + rememberedNumber
                }
                if operation == "-" {
                    currentNumber = -(currentNumber - rememberedNumber)
                }
                if operation == "X" {
                    currentNumber = currentNumber * rememberedNumber
                }
                if operation == "/" {
                    currentNumber = rememberedNumber / currentNumber
                }
            }
            rememberedNumber = currentNumber
            
            currentNumber = 0
            
            performMath = true
            operation = text
        } else if text == "=" {
            if operation == "+" {
                currentNumber = currentNumber + rememberedNumber
            }
            if operation == "-" {
                currentNumber = -(currentNumber - rememberedNumber)
            }
            if operation == "X" {
                currentNumber = currentNumber * rememberedNumber
            }
            if operation == "/" {
                currentNumber = rememberedNumber / currentNumber
            }
            label.text = "\(currentNumber)"
            correct()
            //rememberedNumber = undefConstant
            isAfterEquality = true
        } else if text == "C" {
            currentNumber = 0
            rememberedNumber = undefConstant
            label.text = ""
        }
    }
    
    fileprivate func setUpButton(button : UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height / 3.4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame)
        view.backgroundColor = .black
        // Do any additional setup after loading the view, typically from a nib.
        stackView.addBackground(color: .black)
        setUpButton(button: clearButton)
        clearButton.addTarget(self, action: #selector(handleOpearation(_:)), for: .touchUpInside)
        for button in digitsButton {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 252/255, green: 18/255, blue: 11/255, alpha: 1.0)
            setUpButton(button: button)
            button.backgroundColor = .darkGray
            button.addTarget(self, action: #selector(handleDigitTapping(_:)), for: .touchUpInside)
        }
        for button in operationButton {
            setUpButton(button: button)
            button.addTarget(self, action: #selector(handleOpearation(_:)), for: .touchUpInside)
        }
        for button in emptyButtons {
            setUpButton(button: button)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

