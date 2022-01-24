//
//  CharacterListViewController.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var changeLanguageButton: UIButton!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    
    private var viewModel: CharacterListInterfaceToViewModelProtocol = CharacterListViewModel(characterListManager: CharacterListManager(dataSource: CharacterListDataSource()))
    
    private var characterListModel: CharacterListModel = CharacterListModel()
    
    private var currentItemsToShow: [CharacterItemModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        self.startSpinner()
        viewModel.loadCharacterList()
        
        viewModel.bindCharacterListModel = { list in
            
            self.stopSpinner()

            guard let list = list else {
                self.showErrorAlert()
                return }
            
            self.characterListModel = list
            
            self.updateItemsToShow()
        }
        
        viewModel.bindServiceError = { error in
        
            self.stopSpinner()
            self.showErrorAlert(message: error.localizedDescription)
        }
    }
    
    func configureUI() {
        
        self.contentView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
        
        changeLanguageButton.setTitle(Localization.Language.english, for: .normal)
        changeLanguageButton.setTitleColor(.systemTeal, for: .normal)
        self.updateChangeLanguageTitle(Localization.Language.english)
        
        segmentedControl.tintColor = UIColor.systemTeal
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor.systemTeal
        segmentedControl.backgroundColor = UIColor.gray
        segmentedControl.setTitle(Localization.CharacterList.breakingBad, forSegmentAt: 0)
        segmentedControl.setTitle(Localization.CharacterList.betterCallSaul, forSegmentAt: 1)
        
        if let font = UIFont(name: "GillSans-Bold", size: 16) {
            segmentedControl.setTitleTextAttributes([.foregroundColor : UIColor.white,
                                                     .font : font],
                                                    for: .selected)
            segmentedControl.setTitleTextAttributes([.foregroundColor : UIColor.white,
                                                     .font : font],
                                                    for: .normal)
        }
        
        let itemWidth: CGFloat = view.frame.width * 0.40
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: 200.0)
        collectionViewLayout.minimumLineSpacing = 15
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        collectionViewLayout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        let characterCollectionViewCellIdentifier = String(describing: CharacterCollectionViewCell.self)
        let characterCollectionViewCellNib = UINib(nibName: characterCollectionViewCellIdentifier, bundle: nil)
        collectionView.register(characterCollectionViewCellNib, forCellWithReuseIdentifier: characterCollectionViewCellIdentifier)
    }
    
    @objc func segmentedControlValueChanged() {
        self.updateItemsToShow()
    }
    
    private func updateItemsToShow() {
        
        DispatchQueue.main.async {
            if self.segmentedControl.selectedSegmentIndex == 0 {
                self.currentItemsToShow = self.characterListModel.breakingBadCharacters ?? []
                
            } else {
                self.currentItemsToShow = self.characterListModel.betterCallSaulCharacters ?? []
            }
            self.collectionView.reloadData()
        }
    }
    
    func showErrorAlert(message: String? = nil) {
        let message = message == nil ? "Server error" : message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: { _ in
            alert.dismiss(animated: false, completion: nil)
        })
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
            alert.dismiss(animated: false, completion: {
                self.startSpinner()
                self.viewModel.loadCharacterList()
            })
        })
        alert.addAction(closeAction)
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    @IBAction func changeLanguageButtonTouchUpInside(_ sender: UIButton) {
        
        if LocalStorage.language == AppLanguage.castellano {
            Locale.updateLanguage(AppLanguage.english)
            self.updateChangeLanguageTitle(Localization.Language.spanish)
        } else if LocalStorage.language == AppLanguage.english {
            Locale.updateLanguage(AppLanguage.castellano)
            self.updateChangeLanguageTitle(Localization.Language.english)
        }
    }
    
    private func updateChangeLanguageTitle(_ title: String) {
        let attributedString = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.systemTeal,
                                                                       .font : UIFont(name: "GillSans-Bold", size: 16)])
        changeLanguageButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func startSpinner() {
       DispatchQueue.main.async {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
       }
    }
    
    private func stopSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }

}

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let characterItemModel = self.currentItemsToShow[indexPath.row]
        
        let characterDetailVC = CharacterDetailViewController(nibName: String(describing: CharacterDetailViewController.self), bundle: nil)
        
        characterDetailVC.model = characterItemModel
        
        self.navigationController?.pushViewController(characterDetailVC, animated: false)
    }
}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let characterItem = self.currentItemsToShow[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCollectionViewCell.self), for: indexPath) as? CharacterCollectionViewCell {
            
            cell.configureCell(model: characterItem)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentItemsToShow.count
    }
}
