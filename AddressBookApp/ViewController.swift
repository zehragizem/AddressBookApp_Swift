//
//  ViewController.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//

import UIKit
import EFQRCode

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var people: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        tableView.delegate = self
        tableView.dataSource = self
        people = DatabaseHelper.shared.getAllContacts()
    }

    // + Butonu tıklandığında
    @IBAction func addPersonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddPerson", sender: self)
    }

    // Tablo veri kaynakları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = people[indexPath.row]
        performSegue(withIdentifier: "showQRCode", sender: selected)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.telephone
        return cell
    }
    // Silme işlemi
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = people[indexPath.row]
            DatabaseHelper.shared.deleteContact(person: personToDelete)
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // Segue ile veri alma
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddPerson",
           let destination = segue.destination as? AddPersonViewController {
            destination.delegate = self
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.existingPerson = people[indexPath.row]
                destination.editIndex = indexPath.row
            }
        }
        else if segue.identifier == "showQRCode",
                let destination = segue.destination as? QRViewController,
                let selectedPerson = sender as? Person {
            destination.selectedPerson = selectedPerson
        }
        
    }

}

// Delegate protokolü
extension ViewController: AddPersonDelegate {
    func didAddPerson(_ person: Person) {
        DatabaseHelper.shared.saveContact(person: person)
        people.append(person)
        tableView.reloadData()
    }
    func didEditPerson(_ person: Person, at index: Int) {
        let oldPerson = people[index]
        DatabaseHelper.shared.updateContact(oldPerson: oldPerson, newPerson: person)
        people[index] = person
        tableView.reloadData()
    }

}

func generateQRCode(from string: String) -> UIImage? {
    if let cgImage = EFQRCode.generate(content: string) {
        return UIImage(cgImage: cgImage)
    }
    return nil
}


