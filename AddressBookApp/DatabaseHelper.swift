//
//  Untitled.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//

import RealmSwift

// MARK: - DatabaseHelper Class
// This singleton class manages interactions with the Realm database, such as adding, deleting, updating, and fetching contacts.
class DatabaseHelper {
    
    // MARK: - Singleton Instance
    // Shared instance of DatabaseHelper to ensure there's only one instance throughout the app.
    static let shared = DatabaseHelper()
    
    // MARK: - Private Realm instance
    // This instance represents the Realm database, which is used to perform read and write operations.
    private var realm = try! Realm()
    
    // MARK: - Database URL
    // This method returns the file URL for the Realm database.
    // It's useful for debugging or accessing the file directly.
    func getDatabaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    // MARK: - Fetching All Contacts
    // This function fetches all the contacts stored in the Realm database.
    // It returns an array of `Person` objects.
    func getAllContacts() -> [Person] {
        return Array(realm.objects(Person.self))
    }
    
    // MARK: - Saving a Contact
    // This function saves a `Person` object to the Realm database.
    // It uses Realm's write transaction to persist the object.
    func saveContact(person: Person) {
        try! realm.write {
            realm.add(person)
        }
    }
    
    // MARK: - Deleting a Contact
    // This function deletes a given `Person` object from the Realm database.
    // It uses Realm's write transaction to delete the object.
    func deleteContact(person: Person) {
        try! realm.write {
            realm.delete(person)
        }
    }
    
    // MARK: - Updating a Contact
    // This function updates an existing `Person` object in the Realm database.
    // It takes an old `Person` object and a new `Person` object with updated data.
    func updateContact(oldPerson: Person, newPerson: Person) {
        try! realm.write {
            oldPerson.name = newPerson.name
            oldPerson.telephone = newPerson.telephone
            oldPerson.address = newPerson.address
        }
    }
}
