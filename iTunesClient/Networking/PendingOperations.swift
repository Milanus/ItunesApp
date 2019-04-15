//
//  PendingOperations.swift
//  iTunesClient
//
//  Created by Milan Schon on 08/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath:Operation]()
    
    let downloadQueue = OperationQueue()
}
