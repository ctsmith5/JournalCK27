//
//  User.swift
//  JournalCK27
//
//  Created by Colin Smith on 7/10/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation
import CloudKit

class User {
    var username: String
    var email: String
    
    let recordID: CKRecord.ID
    let appleUserReference: CKRecord.Reference
    
    init(username: String, email: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString) , appleUserReference: CKRecord.Reference){
        self.username = username
        self.email = email
        self.recordID = recordID
        self.appleUserReference = appleUserReference
    }
}

extension User {
   convenience init?(record: CKRecord) {
        guard let username = record[UserConstants.usernameKey] as? String,
            let email = record[UserConstants.emailKey] as? String,
            let appleUserReference = record[UserConstants.appleUserReferenceKey] as? CKRecord.Reference else {return nil}
        self.init(username: username, email: email, recordID: record.recordID, appleUserReference: appleUserReference)
    }
}


extension CKRecord {
    convenience init(user: User){
        self.init(recordType: UserConstants.typeKey, recordID: user.recordID)
        self.setValue(user.username, forKey: UserConstants.usernameKey)
        self.setValue(user.email, forKey: UserConstants.emailKey)
        self.setValue(user.appleUserReference, forKey: UserConstants.appleUserReferenceKey)
    }
}


struct UserConstants {
    static let typeKey = "User"
    fileprivate static let usernameKey = "Username"
    fileprivate static let emailKey = "Email"
    fileprivate static let appleUserReferenceKey = "AppleUserReferenceKey"
}
