//
//  HomeViewController.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private enum Contants {
        static let titleAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.principal,
            .foregroundColor: UIColor.black
        ]
        
        static let buttonAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.button,
            .foregroundColor: UIColor.black
        ]
    }
    
    private let titleLabel = UILabel()
    private let calculateButton = UIButton()
    private let addWorker = UIButton()
    private let departments = UIButton()
    private let workers = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        let buttonsStack = UIStackView(arrangedSubviews: [ calculateButton, addWorker, departments, workers])
        buttonsStack.axis = .vertical
        buttonsStack.distribution = .fill
        buttonsStack.alignment = .center
        buttonsStack.spacing = 20
       
        
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsStack)
        
        titleLabel.attributedText = .init(string: "Pago de nómina", attributes: Contants.titleAttrs)
        
        calculateButton.setAttributedTitle(NSAttributedString(string: "Calcular Nómina", attributes: Contants.buttonAttrs), for: .normal)
        addWorker.setAttributedTitle(NSAttributedString(string: "Agregar Empleado", attributes: Contants.buttonAttrs), for: .normal)
        departments.setAttributedTitle(NSAttributedString(string: "Departamentos", attributes: Contants.buttonAttrs), for: .normal)
        workers.setAttributedTitle(NSAttributedString(string: "Trabajadores", attributes: Contants.buttonAttrs), for: .normal)
        
        calculateButton.backgroundColor = .clear
        addWorker.backgroundColor = .clear
        departments.backgroundColor = .clear
        workers.backgroundColor = .clear
        
        calculateButton.layer.borderWidth = 1
        addWorker.layer.borderWidth = 1
        departments.layer.borderWidth = 1
        workers.layer.borderWidth = 1
        
        calculateButton.layer.borderColor = UIColor.redColor.cgColor
        addWorker.layer.borderColor = UIColor.redColor.cgColor
        departments.layer.borderColor = UIColor.redColor.cgColor
        workers.layer.borderColor = UIColor.redColor.cgColor
        
        calculateButton.layer.cornerRadius = 8
        addWorker.layer.cornerRadius = 8
        departments.layer.cornerRadius = 8
        workers.layer.cornerRadius = 8
        
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        addWorker.addTarget(self, action: #selector(addEmployee), for: .touchUpInside)
        departments.addTarget(self, action: #selector(viewDepartments), for: .touchUpInside)
        workers.addTarget(self, action: #selector(viewEmployees), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            calculateButton.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor, constant: 0),
            addWorker.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor, constant: 0),
            departments.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor, constant: 0),
            workers.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor, constant: 0)
        ])
    }
    
    
    @objc func calculate() {
        let alert = UIAlertController(title: "Calculo de nómina", message: "Se ha calculado la nomina para pago", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            let listOfEmployees =  ListOfEmployees()
            listOfEmployees.isPayment = true
            self.navigationController?.pushViewController(listOfEmployees, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addEmployee() {
        let addVC = AddNewEmployeeViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func viewDepartments() {
        print("Se ven departamentos")
        let departments = DepartmentsListViewController()
        navigationController?.pushViewController(departments, animated: true)
    }
    
    @objc func viewEmployees() {
        print("Se ven empleados")
        let listVC = ListOfEmployees()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
}
