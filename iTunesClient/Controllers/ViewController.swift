//
//  ViewController.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchEndPoint = Itunes.search(term: "taylor swift", media: .music(entity: .musicArtist, attribute: .artistTerm))
        print(searchEndPoint.request)
        print("************")
        let lookupEndPoint = Itunes.lookup(id:159260351 , entity: MusicEntity.album)
        print(lookupEndPoint.request)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

