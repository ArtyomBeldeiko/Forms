//
//  FormFieldType.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 27.01.23.
//

import Foundation
import UIKit


protocol FieldUpdatable {
    func update(with field: Field)
}

protocol FieldConformity {
    var field: Field? { get set }
}

enum FormFieldType {
    case textual
    case numeric
    case valuable
    
    static func registerCells(for tableView: UITableView) {
        tableView.register(FormTextualTableViewCell.self, forCellReuseIdentifier: FormTextualTableViewCell.identifier)
        tableView.register(FormNumericTableViewCell.self, forCellReuseIdentifier: FormNumericTableViewCell.identifier)
        tableView.register(FormValuableTableViewCell.self, forCellReuseIdentifier: FormValuableTableViewCell.identifier)
    }
    
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch self {
        case .textual:
            cell = tableView.dequeueReusableCell(withIdentifier: FormTextualTableViewCell.identifier, for: indexPath)
        case .numeric:
            cell = tableView.dequeueReusableCell(withIdentifier: FormNumericTableViewCell.identifier, for: indexPath)
        case .valuable:
            cell = tableView.dequeueReusableCell(withIdentifier: FormValuableTableViewCell.identifier, for: indexPath)
        }
        
        return cell
    }
}
