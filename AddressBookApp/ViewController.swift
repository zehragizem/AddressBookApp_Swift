import UIKit
import EFQRCode

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PersonCellDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var people: [Person] = []  // List of all people
    var filteredPeople: [Person] = []  // List of filtered people based on search

    // MARK: - viewDidLoad
    // Initializes the view and sets up the table view and search bar
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        people = DatabaseHelper.shared.getAllContacts()
        filteredPeople = people
    }

    // MARK: - Search Bar Delegate
    // Filters the contacts based on search text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPeople = people
        } else {
            filteredPeople = people.filter { person in
                person.name.lowercased().contains(searchText.lowercased()) ||
                person.telephone.contains(searchText) ||
                person.address.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }

    // MARK: - Search Bar Cancel Button
    // Resets the search bar and shows all people when cancel button is tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredPeople = people
        tableView.reloadData()
    }

    // MARK: - Add Person Button
    // Navigates to the Add Person screen when the "+" button is tapped
    @IBAction func addPersonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddPerson", sender: self)
    }

    // MARK: - Table View Data Source
    // Returns the number of rows in the table view based on filtered people
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }

    // MARK: - Table View Cell
    // Configures each cell with person details
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = filteredPeople[indexPath.row]  // Use filteredPeople instead of people
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        cell.nameLabel.text = person.name
        cell.phoneLabel.text = person.telephone
        cell.addressLabel.text = person.address
        cell.person = person
        cell.delegate = self
        return cell
    }

    // MARK: - QR Button Delegate
    // Navigates to the QR code screen when the QR button is tapped
    func didTapQRButton(for person: Person) {
        performSegue(withIdentifier: "showQRCode", sender: person)
    }
    
    // MARK: - Table View Delete Action
    // Handles deleting a contact when swipe-to-delete is used
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = filteredPeople[indexPath.row]  // Use filteredPeople here
            DatabaseHelper.shared.deleteContact(person: personToDelete)
            // Remove from both filteredPeople and people
            if let indexInPeople = people.firstIndex(of: personToDelete) {
                people.remove(at: indexInPeople)
            }
            filteredPeople.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Prepare for Segue
    // Prepares the data before navigating to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddPerson",
           let destination = segue.destination as? AddPersonViewController {
            destination.delegate = self

            if let indexPath = tableView.indexPathForSelectedRow {
                destination.existingPerson = filteredPeople[indexPath.row]  // Use filteredPeople here
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

// MARK: - AddPersonDelegate Extension
// Handles addition and editing of contacts
extension ViewController: AddPersonDelegate {
    func didAddPerson(_ person: Person) {
        DatabaseHelper.shared.saveContact(person: person)
        people.append(person)  // Add to both people and filteredPeople
        filteredPeople.append(person)
        tableView.reloadData()
    }

    func didEditPerson(_ person: Person, at index: Int) {
        let oldPerson = people[index]
        DatabaseHelper.shared.updateContact(oldPerson: oldPerson, newPerson: person)
        people[index] = person
        if let filteredIndex = filteredPeople.firstIndex(of: oldPerson) {
            filteredPeople[filteredIndex] = person
        }
        tableView.reloadData()
    }
}

// MARK: - QR Code Generation
// Generates a QR code image from a string
func generateQRCode(from string: String) -> UIImage? {
    if let cgImage = EFQRCode.generate(content: string) {
        return UIImage(cgImage: cgImage)
    }
    return nil
}
