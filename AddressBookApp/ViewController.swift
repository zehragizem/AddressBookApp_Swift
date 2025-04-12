//
//  ViewController.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        tableView.delegate = self
        tableView.dataSource = self
    }

    // + Butonu tıklandığında
    @IBAction func addPersonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddPerson", sender: self)
    }

    // Tablo veri kaynakları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
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
        
    }

}

// Delegate protokolü
extension ViewController: AddPersonDelegate {
    func didAddPerson(_ person: Person) {
        people.append(person)
        tableView.reloadData()
    }
    func didEditPerson(_ person: Person, at index: Int) {
        people[index] = person
        tableView.reloadData()
    }

}


