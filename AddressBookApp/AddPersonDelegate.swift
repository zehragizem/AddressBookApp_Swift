//
//  AddPersonDelegate.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//


import UIKit

protocol AddPersonDelegate: AnyObject {
    func didAddPerson(_ person: Person)
}

class AddPersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    weak var delegate: AddPersonDelegate?

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              let tel = telephoneTextField.text,
              let address = addressTextField.text,
              !name.isEmpty, !tel.isEmpty else {
            return // boş alanlar varsa işlem yapma
        }

        let newPerson = Person(name: name, telephone: tel, address: address)
        delegate?.didAddPerson(newPerson)
        navigationController?.popViewController(animated: true)
    }
}
