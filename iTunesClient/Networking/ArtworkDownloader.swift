//
//  ArtworkDownloader.swift
//  iTunesClient
//
//  Created by Milan Schon on 08/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation
import UIKit
class ArtworkDownloader:Operation {
    let album:Album
    init(album:Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        guard let url = URL(string:album.artworkUrl)else {
            return
        }
        let imageData = try! Data(contentsOf: url)
        if self.isCancelled {
            return
        }
        if imageData.count>0 {
            album.artwork = UIImage(data:imageData)
            album.aertworkState = .downloaded
        } else {
            album.aertworkState = .failed
        }
    }
}
