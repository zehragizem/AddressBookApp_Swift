//
//  QRViewController.swift
//  AddressBookApp
//
//  Created by Gizem Duman on 13.04.2025.
//


import UIKit

class QRViewController: UIViewController {

    @IBOutlet weak var qrImageView: UIImageView!
    var selectedPerson: Person?
    
    // MARK: - viewDidLoad
    // Sets up the QR code for the selected person's details
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = selectedPerson {
            let jsonString = """
            {
                "name": "\(person.name)",
                "telephone": "\(person.telephone)",
                "address": "\(person.address)"
            }
            """
            if let qrImage = generateQRCode(from: jsonString) {
                qrImageView.image = qrImage
            }
        }
    }
}
