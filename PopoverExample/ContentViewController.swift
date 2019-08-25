//
//  ContentViewController.swift
//  PopoverExample
//
//  Created by Hajime Imamura on 2019/08/25.
//  Copyright © 2019 imamurh. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    enum Item {
        case red, green, blue

        var color: UIColor {
            switch self {
            case .red: return .red
            case .green: return .green
            case .blue: return .blue
            }
        }
    }

    lazy var items: [Item] = {
        return (0..<500).map { _ in
            switch arc4random_uniform(3) {
            case 0: return .red
            case 1: return .green
            default: return .blue
            }
        }
    }()
}

extension ContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = items[indexPath.item].color
        return cell
    }
}
