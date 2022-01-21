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
    @IBOutlet private weak var updateListButton: UIButton!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var viewModel: CharacterListInterfaceToViewModelProtocol = CharacterListViewModel(characterListManager: CharacterListManager(dataSource: CharacterListDataSource()))
    
    private var characterListModel: CharacterListModel = CharacterListModel()
    
    private var currentItemsToShow: [CharacterItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewModel.loadCharacterList()
        
        viewModel.bindCharacterListModel = { list in
            
            guard let list = list else { return }
            
            self.characterListModel = list
            
            self.updateItemsToShow()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func configureUI() {
        
        self.contentView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
        
        updateListButton.setTitle("Update", for: .normal)
        updateListButton.setTitleColor(.purple, for: .normal)
        
        segmentedControl.tintColor = UIColor.systemTeal
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor.systemTeal
        segmentedControl.backgroundColor = UIColor.gray
        segmentedControl.setTitle("Breaking Bad", forSegmentAt: 0)
        segmentedControl.setTitle("Better Call Saul", forSegmentAt: 1)
        
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
    
    @IBAction func updateListButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    
}

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
