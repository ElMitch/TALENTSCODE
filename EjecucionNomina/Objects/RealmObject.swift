//
//  RealmObject.swift
//  EjecucionNomina
//
//  Created by Mitch Samaniego on 15/09/21.
//

import Foundation
import RealmSwift

class EmployeeDB: Object {
    @objc dynamic var number: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var department: String = ""
    @objc dynamic var salary: String = ""
}
