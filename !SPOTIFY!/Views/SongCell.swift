//
//  SongCell.swift
//  !SPOTIFY!
//
//  Created by Erin Scully on 10/18/20.
//

import UIKit
import MarqueeLabel

class SongCell: UITableViewCell {


    @IBOutlet weak var titleLabel: MarqueeLabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    
  

    
    
    
    func updateSongCell(with song: Song){
        titleLabel.text = song.title
        artistLabel.text = song.artist
        titleLabel.type = .leftRight
        titleLabel.speed = .rate(30)
        titleLabel.textAlignment = .center
    }
    
}
