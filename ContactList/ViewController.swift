//
//  ViewController.swift
//  ContactList
//
//  Created by Jenish Mistry on 04/02/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var phoneContactsArray = [PhoneContact]()
    private var filter = ContactsFilter.none
    private var store = CNContactStore()
    private var phoneContactModel = PhoneContactsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.requestAccess { (isAllow) in
                if isAllow {
                    self.loadContacts(filter: self.filter)
                }
            }
        }
    }
    
    // MARK: - Helper Method-
    
    func initView() {
        tableView.register(UINib.init(nibName: ContactTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ContactTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    func loadContacts(filter: ContactsFilter) {
        phoneContactsArray.removeAll()
        phoneContactsArray = phoneContactModel.loadContacts(filter: .none)
        DispatchQueue.main.async {
            self.tableView.reloadData() 
        }
    }
    
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied:
            showSettingsAlert(completionHandler)
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        self.showSettingsAlert(completionHandler)
                    }
                }
            }
        default:
            completionHandler(false)
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings) {
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
                completionHandler(false)
                UIApplication.shared.open(settings)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneContactsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        cell.setContactData(contact: phoneContactsArray[indexPath.row])
        return cell
    }
}
