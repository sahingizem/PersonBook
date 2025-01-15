//
//  UserDetailController.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import Foundation
import UIKit

// this controller does not need to contain any data logic so I preferred not to implement a view model in this scene.

class UserDetailController: UIViewController {
    
    // The 'user' property will hold the data of the user whose details we want to display
    var user: User?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling updateUI when the view is loaded to display the user data
        updateUI()
    }
    
    private func updateUI() {
        
        // Update each label with the user data, and provide a default "N/A" if any data is missing.

        nameLabel.text = "\(user?.name ?? "N/A")"
        emailLabel.text = "Email: \(user?.email ?? "N/A")"
        phoneLabel.text = "Phone: \(user?.phone ?? "N/A")"
        websiteLabel.text = "Website: \(user?.website ?? "N/A")"
        
        streetLabel.text = "Street: \(user?.address?.street ?? "N/A")"
        cityLabel.text = "City: \(user?.address?.city ?? "N/A")"
        zipcodeLabel.text = "Zipcode: \(user?.address?.zipcode ?? "N/A")"
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
          // Close the current modal view controller
          dismiss(animated: true, completion: nil)
      }
}
