//
//  EmployeeCell.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import UIKit

class EmployeeCell: UITableViewCell {
    static let identifier = "EmployeeCell_identifier"
    
    private var roundView = UIView()
    private var nameOfEmployee = UILabel()
    private var payment = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.addSubview(roundView)
        roundView.translatesAutoresizingMaskIntoConstraints = false
        
        roundView.addSubview(nameOfEmployee)
        roundView.addSubview(payment)
        payment.translatesAutoresizingMaskIntoConstraints = false
        nameOfEmployee.translatesAutoresizingMaskIntoConstraints = false
        payment.textAlignment = .right
        
        NSLayoutConstraint.activate([
            roundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            roundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            roundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            roundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            nameOfEmployee.leadingAnchor.constraint(equalTo: roundView.leadingAnchor, constant: 10),
            //nameOfEmployee.trailingAnchor.constraint(equalTo: roundView.trailingAnchor, constant: -10),
            nameOfEmployee.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 10),
            nameOfEmployee.bottomAnchor.constraint(equalTo: roundView.bottomAnchor, constant: -10),
            
            payment.leadingAnchor.constraint(equalTo: nameOfEmployee.trailingAnchor, constant: 5),
            payment.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 10),
            payment.bottomAnchor.constraint(equalTo: roundView.bottomAnchor, constant: -10),
            payment.trailingAnchor.constraint(equalTo: roundView.trailingAnchor, constant: -10)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(employee: EmployeeDB, isPayment: Bool) {
        roundView.backgroundColor = .white
        nameOfEmployee.text = employee.name + " " + employee.lastName
        payment.text = isPayment ? String(Int(employee.salary)! * 15) : ""
    }
    
    func configureWithDepartment(department: String) {
        nameOfEmployee.text = department
    }
}
