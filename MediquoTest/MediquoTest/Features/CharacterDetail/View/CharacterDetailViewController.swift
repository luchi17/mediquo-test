//
//  CharacterDetailViewController.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var model: CharacterItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "GillSans-Bold", size: 16)
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont(name: "GillSans-Bold", size: 14)
        
        imageView.contentMode = .scaleAspectFit
        
        setModel()
    }
    
    func setModel() {
//        titleLabel.text = model?.title
//        subtitleLabel.text = model?.description
//        if let imageUrlString = model?.imageUrlString {
//            imageView.image = Utils.getImage(from: imageUrlString)
//        }
        
    }
}


//Cabecera: imagen, nick, nombre del actor.
//Detalle: nombre, edad, temporadas en las que aparece y

//sus frases famosas. --> /api/quote?author=Jesse+Pinkman
