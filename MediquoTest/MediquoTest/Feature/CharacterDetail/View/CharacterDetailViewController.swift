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
    
    @IBOutlet private weak var stackView: UIStackView!
    
    private var viewModel: CharacterDetailInterfaceToViewModelProtocol = CharacterDetailViewModel(characterDetailManager: CharacterDetailManager( dataSource: CharacterDetailDataSource()))
    
    var model: CharacterItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        
        self.setEmptyModel()
        
        guard let model = model else { return }
        
        viewModel.loadCharacterQuotes(characterItem: model)
        
        viewModel.quotes.observe = { quotes in
            
            self.setModel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    func configureUI() {
        
        contentView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.6)
        
        [nameLabel, nickLabel, ageLabel, seasonsLabel, quotesLabel].forEach({
            $0?.numberOfLines = 0
            $0?.textAlignment = .center
            $0?.font = UIFont(name: "GillSans-Bold", size: 16)
        })
        
        [nameValueLabel, nickValueLabel, ageValueLabel, seasonsValueLabel, quotesValueLabel].forEach({
            $0?.numberOfLines = 0
            $0?.textAlignment = .center
            $0?.font = UIFont(name: "GillSans", size: 16)
        })
    }
    
    func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationItem.backButtonTitle = ""

        let titleAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.systemTeal,
                                                               .font: UIFont(name: "GillSans", size: 18)]

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = titleAttributes
            appearance.largeTitleTextAttributes = titleAttributes
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setModel() {
        
        guard let model = model else {
            return
        }

        nameLabel.text = Localization.CharacterDetail.name.uppercased()
        nickLabel.text = Localization.CharacterDetail.nick.uppercased()
        ageLabel.text = Localization.CharacterDetail.age.uppercased()
        seasonsLabel.text = Localization.CharacterDetail.seasons.uppercased()
        quotesLabel.text = Localization.CharacterDetail.quotes.uppercased()
        
        nameLabel.isHidden = model.name.isEmpty
        nickLabel.isHidden = model.nickname.isEmpty
        seasonsLabel.isHidden = model.seasons.isEmpty
        quotesLabel.isHidden = model.quotes?.isEmpty ?? true
        
        imageView.image = model.image
        nameValueLabel.text = model.name
        nickValueLabel.text = model.nickname
        ageValueLabel.text = model.age
        seasonsValueLabel.text = model.seasons
        quotesValueLabel.text = model.quotes
    }
    
    private func setEmptyModel() {
        [nameLabel, nickLabel, ageLabel, seasonsLabel, quotesLabel, nameValueLabel, nickValueLabel, ageValueLabel, seasonsValueLabel, quotesValueLabel].forEach({
            $0?.text = ""
        })
        imageView.image = nil
    }
}
