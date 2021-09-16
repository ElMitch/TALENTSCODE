//
//  DepartmentsListViewController.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import UIKit
import Realm
import RealmSwift

class DepartmentsListViewController: UITableViewController {
    
    private var employees: [EmployeeDB] = []
    private var departments: [String] = []
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchEmployees()
        title = "Lista de departamentos"
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
        for employee in employees {
            self.departments.append(employee.department)
            self.tableView.reloadData()
        }
    }
}

extension DepartmentsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        departments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
        cell.configureWithDepartment(department: departments[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = ListOfEmployees()
        detail.isDepartment = true
        detail.department = departments[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}

