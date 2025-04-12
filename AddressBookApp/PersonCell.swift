//
//  PersonCellDelegate.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 13.04.2025.
//


import UIKit

// MARK: - PersonCellDelegate Protocol
// This protocol defines the method for notifying the delegate when a QR button is tapped.
protocol PersonCellDelegate: AnyObject {
    func didTapQRButton(for person: Person)
}

class PersonCell: UITableViewCell {
    
    // MARK: - IBOutlets
    // These are the outlets that connect the UI elements from the storyboard.
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var qrButton: UIButton!

    // MARK: - Properties
    // Delegate for handling QR button tap events.
    weak var delegate: PersonCellDelegate?
    var person: Person?

    // MARK: - Actions
    // Called when the QR button is tapped
    // Notifies the delegate with the corresponding person.
    @IBAction func qrButtonTapped(_ sender: UIButton) {
        if let person = person {
            delegate?.didTapQRButton(for: person)
        }
    }
}
