//
//  ListOfEmployees.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import UIKit
import Realm
import RealmSwift

class ListOfEmployees: UITableViewController {
    
    private var employees: [EmployeeDB] = []
    var realm = try! Realm()
    var isDepartment: Bool = false
    var department: String = ""
    var isPayment: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchEmployees()
        title = "Lista de empleados"
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.layoutMargins.bottom = 10
        tableView.separatorInset.bottom = 10
        
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.identifier)
    }
    
    private func fetchEmployees() {
        let employees = try! realm.objects(EmployeeDB.self)
        if !isDepartment {
            for employee in employees {
                self.employees.append(employee)
                self.tableView.reloadData()
            }
        } else {
            for employee in employees {
                if employee.department == self.department {
                    self.employees.append(employee)
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension ListOfEmployees {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
        cell.configureWith(employee: employees[indexPath.row], isPayment: isPayment)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = EmployeeDetailViewController()
        detail.employee = employees[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}
