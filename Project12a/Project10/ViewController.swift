//
//  ViewController.swift
//  Project10
//
//  Created by Jessica Bommer on 23/9/21.
//

import UIKit

final class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - public variables

    var people = [Person]()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Project 10"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "PersonCell", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue a Person Cell.")
        }

        let person = people[indexPath.item]
        cell.nameLabel.text = person.name

        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.4).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func showAlert(title: String, message: String? = nil, indexPath: IndexPath) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .default) {
            [weak self] _ in
            self?.people.remove(at: indexPath.row)
            self?.collectionView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self] _ in
            self?.showAlertWithRenameOption(title: "Rename", indexPath: indexPath)
        })
        present(alert, animated: true)
    }

    func showAlertWithRenameOption(title: String, message: String? = nil, indexPath: IndexPath) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self, weak alert] _ in
                guard let person = self?.people[indexPath.item] else { return }
                guard let newName = alert?.textFields?[0].text else { return }
                person.name = newName
                self?.save()
                self?.collectionView.reloadData()
        })
        present(alert, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert(title: "Choose option", indexPath: indexPath)
    }

    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
}


