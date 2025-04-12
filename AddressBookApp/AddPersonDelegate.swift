//
//  AddPersonDelegate.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//


import UIKit

protocol AddPersonDelegate: AnyObject {
    func didAddPerson(_ person: Person)
    func didEditPerson(_ person: Person, at index: Int)
}


class AddPersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    var existingPerson: Person?
    var editIndex: Int?

    weak var delegate: AddPersonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let person = existingPerson {
            nameTextField.text = person.name
            telephoneTextField.text = person.telephone
            addressTextField.text = person.address
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              let tel = telephoneTextField.text,
              let address = addressTextField.text,
              !name.isEmpty, !tel.isEmpty else {
            return
        }

        let updatedPerson = Person(name: name, telephone: tel, address: address)

        if let index = editIndex {
            delegate?.didEditPerson(updatedPerson, at: index)
        } else {
            delegate?.didAddPerson(updatedPerson)
        }

        navigationController?.popViewController(animated: true)
    }

}
