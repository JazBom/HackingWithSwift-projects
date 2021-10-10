//
//  ViewController.swift
//  Project1
//
//  Created by Jessica Bommer on 17/9/21.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        let sortedItems = items.sorted()
        for item in sortedItems {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        print(pictures)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pictures.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath)
//        imageTitleLabel.text = "Picture \(indexPath.item + 1)"
//        imageView.image = UIImage(named: pictures[indexPath.item])

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "PictureCell", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue a Person Cell.")
        }

        let picture = pictures[indexPath.item]
        cell.imageView.image = UIImage(contentsOfFile: picture)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.selectedImage = pictures[indexPath.item]
            viewController.title = "Picture \(indexPath.item + 1) of \(pictures.count)"
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

