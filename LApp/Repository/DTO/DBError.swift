//
//  DBError.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
}
