//
//  SearcheResultDataSource.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class SearcheResultDataSource: NSObject,UITableViewDataSource {
  
    
    private var data = [Artist]()
    
    override init() {
        super.init()
    }
    
    func update(with artist:[Artist]) {
        data = artist
    }
    
    // MARK Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let artis = data[indexPath.row]
        cell.textLabel?.text = artis.name
        return cell
    }
    
    //MARK : Helper methods
    func artist(at indexPath:IndexPath) -> Artist {
        return data[indexPath.row]
    }
    
}
