//
//  PhoneContactssModel.swift
//  ContactList
//
//  Created by Jenish Mistry on 04/02/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import Foundation
import ContactsUI

enum ContactsFilter {
    case none
    case mail
    case message
}
class PhoneContactsModel {
    var phoneContacts = [PhoneContact]() // array of PhoneContact(It is model find it below)
    var filter: ContactsFilter = .none
    
    func loadContacts(filter: ContactsFilter) -> [PhoneContact] {
        phoneContacts.removeAll()
        var allContacts = [PhoneContact]()
        for contact in PhoneContacts.getContacts(filter: filter) {
            allContacts.append(PhoneContact(contact: contact))
        }
        
        var filterdArray = [PhoneContact]()
        if self.filter == .mail {
            filterdArray = allContacts.filter({ $0.email.count > 0 }) // getting all email
        } else if self.filter == .message {
            filterdArray = allContacts.filter({ $0.phoneNumber.count > 0 })
        } else {
            filterdArray = allContacts
        }
        phoneContacts.append(contentsOf: filterdArray)
        
        for contact in phoneContacts {
            print("Name -> \(String(describing: contact.name))")
            print("Email -> \(contact.email)")
            print("Phone Number -> \(contact.phoneNumber)")
            print("Phone image -> \(String(describing: contact.avatarData))")
            
        }
        return self.phoneContacts

    }


}

class PhoneContact: NSObject {
    var name: String?
    var avatarData: Data?
    var phoneNumber: [String] = [String]()
    var email: [String] = [String]()
    var isSelected: Bool = false
    var isInvited = false
    
    init(contact: CNContact) {
        name        = contact.givenName + " " + contact.familyName
        avatarData  = contact.thumbnailImageData
        for phone in contact.phoneNumbers {
            phoneNumber.append(phone.value.stringValue)
        }
        for mail in contact.emailAddresses {
            email.append(mail.value as String)
        }
    }
    
    override init() {
        super.init()
    }
}
