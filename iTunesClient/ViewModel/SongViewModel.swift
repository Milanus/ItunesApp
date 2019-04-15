//
//  SongViewModel.swift
//  iTunesClient
//
//  Created by Milan Schon on 06/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation

struct SongViewModel {
    let title:String
    let runTime:String
}

extension SongViewModel {
    init(song:Song) {
        let timeInSeconds = song.trackTime/1000
        let minutes  = timeInSeconds/60%60
        let seconds = timeInSeconds%60
        self.runTime = "\(minutes): \(seconds)"
        self.title = song.censoredName
    }
}
