//
//  Person.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//
import RealmSwift

// MARK: - Person Class
// This class represents a person entity that is stored in the Realm database.
// It has properties such as 'id', 'name', 'telephone', and 'address' which are persisted using Realm's @Persisted property wrapper.
class Person: Object {
    
    // MARK: - Properties
    // Unique identifier for the person (generated with UUID).
    @Persisted var id: String = UUID().uuidString
    
    // Name of the person.
    @Persisted var name: String = ""
    
    // Telephone number of the person.
    @Persisted var telephone: String = ""
    
    // Address of the person.
    @Persisted var address: String = ""
    
    // MARK: - Initializer
    // Convenience initializer to easily create a new Person instance with provided parameters.
    convenience init(name: String, telephone: String, address: String) {
        self.init()
        self.name = name
        self.telephone = telephone
        self.address = address
    }
    
    // MARK: - Realm Configuration
    // This method defines the primary key for the Person object.
    // In this case, the 'id' property is the primary key, which ensures uniqueness of each person in the database.
    override static func primaryKey() -> String? {
        return "id"
    }
}
