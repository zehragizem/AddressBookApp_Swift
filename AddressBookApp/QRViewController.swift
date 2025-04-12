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
