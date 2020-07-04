//
//  ContactTableViewCell.swift
//  ContactList
//
//  Created by Jenish Mistry on 04/02/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactIcon: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setContactData(contact: PhoneContact) {
        self.contactIcon.layer.cornerRadius = self.contactIcon.frame.size.height / 2
        self.contactIcon.layer.masksToBounds = true
        
        if let imgData = contact.avatarData{
            self.contactIcon.image = UIImage(data: imgData)
        }else{
            self.contactIcon.image = UIImage(named: "")
        }
        
        self.contactName.text = contact.name
    }
    
}
