//
//  ItunesError.swift
//  iTunesClient
//
//  Created by Milan Schon on 07/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation

enum ItunesError:Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(msg:String)
}
