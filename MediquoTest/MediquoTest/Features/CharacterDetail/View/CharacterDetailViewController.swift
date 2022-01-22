//
//  CharacterDetailViewController.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameValueLabel: UILabel!
    @IBOutlet private weak var nickLabel: UILabel!
    @IBOutlet private weak var nickValueLabel: UILabel!
    
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var ageValueLabel: UILabel!
    @IBOutlet private weak var seasonsLabel: UILabel!
    @IBOutlet private weak var seasonsValueLabel: UILabel!
    @IBOutlet private weak var quotesLabel: UILabel!
    @IBOutlet private weak var quotesValueLabel: UILabel!
    
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    
    var model: CharacterItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .clear // change the navigation background color
    }
    
    func configureUI() {
        
        contentView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
        
        [nameLabel, nickLabel, ageLabel, seasonsLabel, quotesLabel].forEach({
            $0?.numberOfLines = 0
            $0?.font = UIFont(name: "GillSans-Bold", size: 16)
            $0?.textColor = UIColor.black
        })
        
        [nameValueLabel, nickValueLabel, ageValueLabel, seasonsValueLabel, quotesValueLabel].forEach({
            $0?.numberOfLines = 0
            $0?.font = UIFont(name: "GillSans", size: 16)
            $0?.textColor = UIColor.black
        })
        
        descriptionTitleLabel.font = UIFont(name: "GillSans", size: 18)
        imageView.layer.cornerRadius = 12.0
    }
    
    private func setModel() {
        
        nameLabel.text = ""
        nickLabel.text = ""
        ageLabel.text = ""
        seasonsLabel.text = ""
        quotesLabel.text = ""
        
        imageView.image = model?.image
        nameValueLabel.text = model?.name
        nickValueLabel.text = model?.nickname
        ageValueLabel.text = model?.age
        seasonsValueLabel.text = model?.seasons
        quotesValueLabel.text = model?.quotes
    }
}
