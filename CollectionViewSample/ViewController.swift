//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by sasaki.ken on 2023/08/29.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var array = ["消防士", "税理士", "中小企業診断士", "一級建築士", "介護士"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpCollectionViewCell()
        setUpCollectionView()
        setUpRefreshControl()
    }
    
    private func setUpCollectionViewCell() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }

    private func setUpCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
    }
    
    private func setUpRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
                        
    @IBAction func onPlusButtonTapped(_ sender: UIButton) {
        array.insert("弁護士", at: 0)
        let newItemIndexPath = IndexPath(item: 0, section: 0)
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [newItemIndexPath])
        }, completion: { _ in
            print("success update.")
        })
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = array[indexPath.row]
        
        return cell
    }
}
