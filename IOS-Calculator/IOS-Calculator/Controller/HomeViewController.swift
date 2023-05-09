//
//  HomeViewController.swift
//  IOS-Calculator
//
//  Created by Laureano Velasco on 07/03/2023.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Outlets
    
    // result
    @IBOutlet weak var resultLabel: UILabel!
    
    // numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    // operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPorcent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operationAdition: UIButton!
    @IBOutlet weak var operationSustraction: UIButton!
    @IBOutlet weak var operationMultiplication: UIButton!
    @IBOutlet weak var operationDivision: UIButton!
    
    //MARK: - Variables
    
    private var total: Double = 0 //Total
    private var temp: Double = 0 // valor en pantalla
    private var operating = false //indicar si se ha seleccionado un operador
    private var decimal = false // indicar si el valor es decimal
    private var operation: OperationType = .none // operacion actual
    
    // MARK: - Constantes
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kTotal = "total"
    
    private enum OperationType {
        case none, addiction, sustraction, multiplication, division, percent
    }
    
    // Formateo de valores Auxiliar
    private let auxFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
        
    }()
    
    // Aux total Formatter: cuenta el numero total de digitos que tiene el total
    private let auxTotalFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
        
    }()
    
    
    //Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumIntegerDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // formateo valores por pantalla en formato cientifico
    private let printScientificFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    
    }()
    
    //MARK: - Initialization
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //UI
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorResult.round()
        operatorPorcent.round()
        operationAdition.round()
        operationDivision.round()
        operationSustraction.round()
        operationMultiplication.round()
        operatorPlusMinus.round()
    }

//MARK: - Button Actions
    
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        
        sender.shine()
        
    }
    
    @IBAction func operationPlusMinusAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    
    @IBAction func operationPorcentAction(_ sender: UIButton) {
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        
        sender.shine()
    }
    
    @IBAction func operationDivisionAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .division
        //FUNCION ANULADA
        //sender.selectOperation(true)
        
        sender.shine()
        
    }
    
    @IBAction func operationMultiplicationAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .multiplication
        //FUNCION ANULADA
        //sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func operationSustractionAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .sustraction
        //FUNCION ANULADA
        //sender.selectOperation(true)
        
        sender.shine()
    }
    @IBAction func operationAditionAction(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addiction
        //FUNCION ANULADA
        //sender.selectOperation(true)
        
        sender.shine()
        
    }
    @IBAction func operationResultAction(_ sender: UIButton) {
        result()
        sender.shine()
    }
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        
        //FUNCION ANULADA
        //selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        // hemos seleccionado una operacion
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        
        //hemos seleccionado decimales
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        //FUNCION ANULADA
        //selectVisualOperation()
        
        sender.shine()
        
        
    }
    
    // MARK: - limpiar valores
    private func clear() {
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    private func result() {
        
        switch operation {
        case .none:
            //nada
            break
        case .addiction:
            total = total + temp
            break
        case .sustraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        // formateo en pantalla
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            resultLabel.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        //FUNCION ANULADA
        //selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)
        
        print("TOTAL: \(total)")
        
    }
    
    //muestra de forma visual la operacion seleccionada
    //FUNCION ANULADA
    
    /*
    private func selectVisualOperation() {
        if !operating {
            //no estamos oeprando
            operationAdition.selectOperation(false)
            operationSustraction.selectOperation(false)
            operationMultiplication.selectOperation(false)
            operationDivision.selectOperation(false)
        } else {
            switch operation {
            case .none, .percent:
                operationAdition.selectOperation(false)
                operationSustraction.selectOperation(false)
                operationMultiplication.selectOperation(false)
                operationDivision.selectOperation(false)
                break
            case .addiction:
                operationAdition.selectOperation(true)
                operationSustraction.selectOperation(false)
                operationMultiplication.selectOperation(false)
                operationDivision.selectOperation(false)
                break
            case .sustraction:
                operationAdition.selectOperation(false)
                operationSustraction.selectOperation(true)
                operationMultiplication.selectOperation(false)
                operationDivision.selectOperation(false)
                break
            case .multiplication:
                operationAdition.selectOperation(false)
                operationSustraction.selectOperation(false)
                operationMultiplication.selectOperation(true)
                operationDivision.selectOperation(false)
                break
            case .division:
                operationAdition.selectOperation(false)
                operationSustraction.selectOperation(false)
                operationMultiplication.selectOperation(false)
                operationDivision.selectOperation(true)
                break
            
                
            }
        }
    }*/
}
