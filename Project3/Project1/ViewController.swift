//
//  ViewController.swift
//  Project1
//
//  Created by Jessica Bommer on 17/9/21.
//

import UIKit

class ViewController: UITableViewController {
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

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let pictureName = "Picture \(indexPath.row + 1)"
        cell.textLabel?.text = pictureName
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.selectedImage = pictures[indexPath.row]
            viewController.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

