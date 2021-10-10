//
//  ViewController.swift
//  Project5
//
//  Created by Jessica Bommer on 21/9/21.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        startGame()
    }

    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc func promptForAnswer() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak alert] action in
            guard let answer = alert?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        alert.addAction(submitAction)
        present(alert, animated: true)
    }

    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    showErrorMessage(title: "Word not recognised", message: "You can't just make them up!")
                }
            } else {
                showErrorMessage(title: "Be more original...", message: "Same word, or already used!")
            }
        } else {
            guard let title = title else { return }
            showErrorMessage(title: "Word not possible", message: "You can't spell that from \(title.lowercased())...")
        }
    }

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    func isOriginal(word: String) -> Bool {
        if !usedWords.contains(word) && word != title?.lowercased() {
            return true
        } else {
            return false
        }
    }

    func isReal(word: String) -> Bool {
        if word.utf16.count > 1 || word == "a" || word == "i" {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspeltRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspeltRange.location == NSNotFound
        } else {
            return false
        }
    }

    func showErrorMessage(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

