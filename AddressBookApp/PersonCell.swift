//
//  PersonCellDelegate.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 13.04.2025.
//


import UIKit

protocol PersonCellDelegate: AnyObject {
    func didTapQRButton(for person: Person)
}

class PersonCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var qrButton: UIButton!

    weak var delegate: PersonCellDelegate?
    var person: Person?

    @IBAction func qrButtonTapped(_ sender: UIButton) {
        if let person = person {
            delegate?.didTapQRButton(for: person)
        }
    }
}
