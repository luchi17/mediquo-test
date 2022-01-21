//
//  CharacterCollectionViewCell.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 26/11/21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       configureUI()
    }
    
    func configureUI() {
        
        errorLabel.isHidden = true
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12.0
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont(name: "GillSans-Bold", size: 14)
        titleLabel.textAlignment = .center
        
        nickNameLabel.textAlignment = .center
        
        errorLabel.font = UIFont(name: "GillSans-Bold", size: 14)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
    }
    
    func configureCell(model: CharacterItemModel) {
        
        titleLabel.text = model.name
        nickNameLabel.text = model.nickname
        imageView.image = model.image
        
        if model.image != nil {
            imageView.image = model.image
            errorLabel.isHidden = true
        } else {
            errorLabel.text = "Image could not be loaded"
            errorLabel.isHidden = false
        }
        
    }
}
