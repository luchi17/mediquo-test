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
    
    private var viewModel: CharacterListInterfaceToViewModelProtocol = CharacterListViewModel(characterListManager: CharacterListManager(dataSource: CharacterListDataSource()))
    
    private var characterListModel: CharacterListModel = CharacterListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    
        viewModel.loadCharacterList()
        
        viewModel.bindCharacterListModel = { list in
            
            guard let list = list else { return }
            
            let uniqueItems = Array(Set(list.items))
            let uniqueItemsSorted = uniqueItems.sorted {$0.name < $1.name}
            self.characterListModel.items = uniqueItemsSorted
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func configureUI() {
 
        self.contentView.backgroundColor = .clear
        
        updateListButton.setTitle("Update", for: .normal)
        updateListButton.setTitleColor(.purple, for: .normal)
        
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
        collectionView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.4)
        
        let characterCollectionViewCellIdentifier = String(describing: CharacterCollectionViewCell.self)
        let characterCollectionViewCellNib = UINib(nibName: characterCollectionViewCellIdentifier, bundle: nil)
        collectionView.register(characterCollectionViewCellNib, forCellWithReuseIdentifier: characterCollectionViewCellIdentifier)
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
        
        let characterItem = self.characterListModel.items[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCollectionViewCell.self), for: indexPath) as? CharacterCollectionViewCell {
            
            cell.configureCell(model: characterItem)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterListModel.items.count
    }
}
