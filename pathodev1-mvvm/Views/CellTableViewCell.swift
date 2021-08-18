//
//  CellTableViewCell.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 14.08.2021.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    
    // MARK: -IBOutlets
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ActorName: UILabel!
    @IBOutlet weak var DateOfBirth: UILabel!
    @IBOutlet weak var CharacterImage: UIImageView!
    @IBOutlet weak var HeartBut: SubClassedUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Designing CharacterImage UIImageView
    override func layoutSubviews() {
        super.layoutSubviews()
        CharacterImage.layer.cornerRadius = 20
        CharacterImage.layer.borderColor = UIColor.black.cgColor
        CharacterImage.layer.borderWidth = 5
            CharacterImage.layer.backgroundColor = UIColor.black.cgColor
        CharacterImage.clipsToBounds = true
    }

}
