//
//  SongCell.swift
//  !SPOTIFY!
//
//  Created by Erin Scully on 10/18/20.
//

import UIKit

class SongCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    func updateSongCell(with song: Song){
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
    
}
