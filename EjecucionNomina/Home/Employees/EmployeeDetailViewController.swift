//
//  EmployeeDetailViewController.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import UIKit
import Realm
import RealmSwift

class EmployeeDetailViewController: UIViewController {
    
    private enum Contants {
        static let buttonAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.button,
            .foregroundColor: UIColor.gray
        ]
    }
    
    private let numberOfEmployee = UITextField()
    private let nameOfEmployee = UITextField()
    private let lastNameOfEmployee = UITextField()
    private let addressOfEmployee = UITextField()
    private let phoneOfEmployee = UITextField()
    private let departmentOfEmployee = UITextField()
    private let salaryOfEmployee = UITextField()
    private let saveEmployee = UIButton()
    private let scrollView = UIScrollView()
    
    var employee: EmployeeDB!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configWithEmployee()
    }
    
    private func configWithEmployee() {
        numberOfEmployee.text = employee.number
        nameOfEmployee.text = employee.name
        lastNameOfEmployee.text = employee.lastName
        addressOfEmployee.text = employee.address
        phoneOfEmployee.text = employee.phone
        departmentOfEmployee.text = employee.department
        salaryOfEmployee.text = employee.salary
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view = scrollView
        scrollView.backgroundColor = .white
        let contentGuide = scrollView.contentLayoutGuide
        
        let mainStackView = UIStackView(arrangedSubviews: [ numberOfEmployee, nameOfEmployee, lastNameOfEmployee, addressOfEmployee, phoneOfEmployee, departmentOfEmployee, salaryOfEmployee, saveEmployee])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 50
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(mainStackView)
        
        numberOfEmployee.placeholder = "Ingresa el n??mero de empleado"
        numberOfEmployee.borderStyle = .roundedRect
        numberOfEmployee.keyboardType = .numberPad
        
        nameOfEmployee.placeholder = "Ingresa el nombre del empleado"
        nameOfEmployee.borderStyle = .roundedRect
        
        lastNameOfEmployee.placeholder = "Ingresa el apellido del empleado"
        lastNameOfEmployee.borderStyle = .roundedRect
        
        addressOfEmployee.placeholder = "Ingresa la direcci??n del empleado"
        addressOfEmployee.borderStyle = .roundedRect
        
        phoneOfEmployee.placeholder = "Ingresa el tel??fono del empleado"
        phoneOfEmployee.borderStyle = .roundedRect
        phoneOfEmployee.keyboardType = .numberPad
        
        departmentOfEmployee.placeholder = "Selecciona el departamento del empleado"
        departmentOfEmployee.borderStyle = .roundedRect
        
        salaryOfEmployee.placeholder = "Ingresa el salario diario del empleado"
        salaryOfEmployee.borderStyle = .roundedRect
        salaryOfEmployee.keyboardType = .numberPad
        
        saveEmployee.backgroundColor = .cyan
        saveEmployee.setAttributedTitle(NSAttributedString(string: "Guardar", attributes: Contants.buttonAttrs), for: .normal)
        saveEmployee.layer.cornerRadius = 10
        saveEmployee.addTarget(self, action: #selector(saveActionEmployee), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            contentGuide.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            mainStackView.centerYAnchor.constraint(equalTo: contentGuide.centerYAnchor, constant: 0),
            mainStackView.centerXAnchor.constraint(equalTo: contentGuide.centerXAnchor, constant: 0),
            mainStackView.topAnchor.constraint(equalTo: contentGuide.topAnchor, constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor, constant: -50),
            
            saveEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            saveEmployee.heightAnchor.constraint(equalToConstant: 30),
            
            numberOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            nameOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            lastNameOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            addressOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            phoneOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            departmentOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0),
            salaryOfEmployee.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 0)
        ])
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func saveActionEmployee() {
        realm.beginWrite()
        realm.delete(employee)
        try! realm.commitWrite()
        
        let employeeDB = EmployeeDB()
        employeeDB.number = numberOfEmployee.text!
        employeeDB.name = nameOfEmployee.text!
        employeeDB.lastName = lastNameOfEmployee.text!
        employeeDB.address = addressOfEmployee.text!
        employeeDB.phone = phoneOfEmployee.text!
        employeeDB.department = departmentOfEmployee.text!
        employeeDB.salary = salaryOfEmployee.text!
        realm.beginWrite()
        realm.add(employeeDB)
        try! realm.commitWrite()
        
        let alert = UIAlertController(title: "Registro completado", message: "El empleado se ha guardado con exito", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: HomeViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
