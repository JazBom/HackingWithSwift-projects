//
//  ViewController.swift
//  Project2
//
//  Created by Jessica Bommer on 17/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1Label: UIButton!
    @IBOutlet var button2Label: UIButton!
    @IBOutlet var button3Label: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1Label.layer.borderWidth = 1
        button2Label.layer.borderWidth = 1
        button3Label.layer.borderWidth = 1

        button1Label.layer.borderColor = UIColor.lightGray.cgColor
        button2Label.layer.borderColor = UIColor.lightGray.cgColor
        button3Label.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1Label.setImage(UIImage(named: countries[0]), for: .normal)
        button2Label.setImage(UIImage(named: countries[1]), for: .normal)
        button3Label.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(alert, animated: true)
    }

    @objc func showScore() {
        let alert = UIAlertController(title: "Total score", message: "\(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

}

