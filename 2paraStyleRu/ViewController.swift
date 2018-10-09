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
    
    @IBAction func equalTapped(_ sender: Any) {
        if (rememberedNumber != undefConstant) {
            evaluate()
        }
    }
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var emptyButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var digitsButton: [UIButton]!
    @IBOutlet var operationButton: [UIButton]!
    
    func evaluate() {
        if operation == "+" {
            performOperation { (a, b) -> Double in
                return a + b
            }
        } else if operation == "X" {
            performOperation { (a, b) -> Double in
                return a * b
            }
        } else if (operation == "/") {
            performOperation { (a, b) -> Double in
                return a / b
            }
        } else if (operation == "-") {
            performOperation { (a, b) -> Double in
                return a - b
            }
        } else {
            print("UNDEFINED OPERATION")
        }
    }
    
    fileprivate func correct() {
        if rememberedNumber - Double(Int(rememberedNumber)) == 0 {
            let temp = Int(rememberedNumber)
            label.text = String(temp)
        } else {
            label.text = String(rememberedNumber)
        }
    }
    
    func performOperation(work: (Double, Double) -> Double) {
        rememberedNumber = work(rememberedNumber, currentNumber)
        correct()
    }
    
    @objc func handleDigitTapping(_ sender : UIButton) {
        label.text! += (sender.titleLabel?.text)!
        currentNumber = Double(label.text!)!
    }
    
    @objc func handleOpearation(_ sender : UIButton) {
        if (label.text?.isEmpty)! {
            return
        }
        operation = (sender.titleLabel?.text)!
        rememberedNumber = Double(label.text!)!
        label.text = ""
    }
    
    fileprivate func setUpButton(button : UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height / 3.4
    }
    
    fileprivate func viewSetUp() {
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
        setUpButton(button: equalButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame)
        viewSetUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

