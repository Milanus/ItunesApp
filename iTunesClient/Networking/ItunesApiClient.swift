//
//  ItunesApiClient.swift
//  iTunesClient
//
//  Created by Milan Schon on 07/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation

class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    func searchForArtist(with term:String, completion:@escaping ([Artist], ItunesError?)->()) {
        let endPoint = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm))
        
        performRequest(with: endPoint) { results,error in
            guard let results = results else {
                completion([],error)
                return
            }
            let artist = results.flatMap{Artist(json: $0)}
            completion(artist,nil)
        }
        
    }
    
    func lookupArtist(with id:Int, completion:@escaping(Artist?,ItunesError?)->Void) {
        let endPoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        performRequest(with: endPoint) { results,error in
            guard let results = results else {
                completion(nil,error)
                return
            }
            guard let artistInfo = results.first else {
                completion(nil,.jsonParsingFailure(msg:"results does not contain artist info"))
                return
            }
            guard let artist = Artist(json: artistInfo) else {
                completion(nil,.jsonParsingFailure(msg:"Could not parse artist information"))
                return
            }
            let albumResults = results[1..<results.count]
            let albums = albumResults.flatMap{Album(json: $0)}
            
            artist.albums = albums
            completion(artist,nil)
        }
    }
    
    func lookupAlbum(with id:Int, completion:@escaping(Album?,ItunesError?)->Void) {
        let endPoint = Itunes.lookup(id: id, entity: MusicEntity.song)
        
        performRequest(with: endPoint) { results,error in
            guard let results = results else {
                completion(nil,error)
                return
            }
            guard let albumInfo = results.first else {
                completion(nil,.jsonParsingFailure(msg:"results does not contain artist info"))
                return
            }
            guard let album = Album(json: albumInfo) else {
                completion(nil,.jsonParsingFailure(msg:"Could not parse artist information"))
                return
            }
            let songResults = results[1..<results.count]
            let songs = songResults.flatMap{Song(json: $0)}
            
            album.songs = songs
            completion(album,nil)
        }
    }
    
    typealias Results = [[String:Any]]
    
    private func performRequest (with endpoint:EndPoint, completion:@escaping (Results?,ItunesError?)->()) {
        let task  = downloader.jsonTask(with: endpoint.request) {json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                guard let result = json["results"] as? [[String:Any]] else {
                    completion(nil,.jsonParsingFailure(msg:"JSon data does not contains results"))
                    return
                }
                let artist = result.flatMap {Artist(json: $0)}
                completion(result,nil)
            }
        }
        task.resume()
    }
}
