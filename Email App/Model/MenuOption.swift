//
//  MenuOption.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation

enum MenuOption: Int, CustomStringConvertible {
    
    case inbox
    case sent
    case archive
    
    var description: String {
        switch self {
            
        case .inbox: return "Inbox"
        case .sent: return "sent"
        case .archive: return "archive"

        }
    }
}
