//
//  AddPersonDelegate.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//


import UIKit

// MARK: - AddPersonDelegate Protocol
// This protocol is used to communicate the addition or editing of a person to the previous view controller.
protocol AddPersonDelegate: AnyObject {
    func didAddPerson(_ person: Person)
    func didEditPerson(_ person: Person, at index: Int)
}

class AddPersonViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var nameTextField: UITextField!  // Text field for the person's name
    @IBOutlet weak var telephoneTextField: UITextField!  // Text field for the person's telephone number
    @IBOutlet weak var addressTextField: UITextField!  // Text field for the person's address
    
    // MARK: - Properties
    var existingPerson: Person?
    var editIndex: Int?
    weak var delegate: AddPersonDelegate?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Setup UI for Editing or Adding a Person
        if let person = existingPerson {  // If an existing person is being edited
            title = "Update Person"
            nameTextField.text = person.name
            telephoneTextField.text = person.telephone
            addressTextField.text = person.address
        } else {  // If no existing person, we're adding a new one
            title = "Create Person"
            nameTextField.text = ""
            telephoneTextField.text = ""
            addressTextField.text = ""
        }
    }

    // MARK: - Save Button Action
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Ensure that the user has entered values for name, telephone, and address
        guard let name = nameTextField.text,
              let tel = telephoneTextField.text,
              let address = addressTextField.text,
              !name.isEmpty, !tel.isEmpty else {
            return  // If any field is empty, do nothing and return
        }
        
        // Create a new person object with the entered data
        let newPerson = Person(name: name, telephone: tel, address: address)

        // MARK: - Delegate Call for Add or Edit
        if let index = editIndex {  // If an index exists, it means we are editing an existing person
            delegate?.didEditPerson(newPerson, at: index)
        } else {  // Otherwise, we are adding a new person
            delegate?.didAddPerson(newPerson)
        }

        // Pop the current view controller and return to the previous screen
        navigationController?.popViewController(animated: true)
    }
}
