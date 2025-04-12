//
//  Untitled.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//

import RealmSwift

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    func getDatabaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL}
    
    func getAllContacts() -> [Person]{
        return Array(realm.objects(Person.self))
    }
    
    func saveContact(person:Person){
        try! realm.write{
            realm.add(person)
        }
    }
    
    func deleteContact(person:Person){
        try! realm.write{
            realm.delete(person)
        }
    }
    
    func updateContact(oldPerson:Person, newPerson:Person){
        try! realm.write{
            oldPerson.name = newPerson.name
            oldPerson.telephone = newPerson.telephone
            oldPerson.address = newPerson.address
        }
    }
    

}
