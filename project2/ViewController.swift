//
//  ViewController.swift
//  project2
//
//  Created by Madiapps on 16/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.purple
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance =
            navigationController?.navigationBar.standardAppearance
        }else{
            navigationController?.navigationBar.backgroundColor = UIColor.purple
        }
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        questionLabel.text = " Question \(counter)/10"
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
             
        self.navigationItem.setTitle(countries[correctAnswer].uppercased(), subtitle: "Your score is \(score)")
        counter += 1
    }
    
    func initQuiz(action: UIAlertAction! = nil) {
        score = 0
        counter = 1
        askQuestion()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, the correct answer is the \(correctAnswer+1) flag"
            score -= 1
        }
        
        if counter == 11 {
            let ac1 = UIAlertController(title: "Try again", message: "Your score is \(score)", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Continue", style: .default, handler: initQuiz))
            present(ac1, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        
    }
    
    
    
}

extension UINavigationItem {

  func setTitle(_ title: String, subtitle: String) {
    let appearance = UINavigationBar.appearance()
    let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .black

    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
    titleLabel.textColor = textColor

    let subtitleLabel = UILabel()
    subtitleLabel.text = subtitle
    subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    subtitleLabel.textColor = textColor.withAlphaComponent(0.75)

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    stackView.axis = .vertical

    self.titleView = stackView
  }
}
