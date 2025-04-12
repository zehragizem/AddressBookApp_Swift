//
//  Person.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 12.04.2025.
//
import RealmSwift

class Person: Object{
    @Persisted var name: String = ""
    @Persisted var telephone: String = ""
    @Persisted var address: String = ""
    
    convenience init(name: String, telephone: String, address:String){
        self.init()
        self.name = name
        self.telephone = telephone
        self.address = address
    }
}
