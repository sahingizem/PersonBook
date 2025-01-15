//
//  UserListController.swift
//  PersonBook
//
//  Created by gizem on 15.01.2025.
//

import UIKit

class UserListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel that handles data fetching and transformation for the user list
    private var viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the tableView and its delegate & data source methods
        setupTableView()
        fetchUsers()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell") // Register the cell type
    }
    
    private func fetchUsers() {
        viewModel.fetchUsers { success in
            // If the fetch is successful, reload the table view on the main thread
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension UserListController: UITableViewDataSource, UITableViewDelegate {
    
    // This function returns the number of rows in the table view by using the view model to fetch the number of users available
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.getUser(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = "\(user.name ?? "Name")\n ✉️\(user.email ?? "Surname")"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.getUser(at: indexPath.row)
        let userDetailVC = UserDetailController()
        userDetailVC.user = user
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userDetailVC = storyboard.instantiateViewController(withIdentifier: "UserDetailController") as? UserDetailController {
            userDetailVC.user = user
            present(userDetailVC, animated: true, completion: nil)
        }
    }
}
