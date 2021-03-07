//
//  ViewController.swift
//  Flashcards
//
//  Created by Angela Darden on 2/20/21.
//

import UIKit

class firstScreenViewController: UIViewController {
    
    // front label is the question
    // back label is the answer
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounded corners
        card.layer.cornerRadius = 20.0
        
        // Shadow options
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        // Rounding corners on the labels
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        // Rounding corners on the buttons
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        
        // Borders
        // Color box shows with "= Color Literal"
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // We know the destinataion of the segue is in the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigationo Controller only contains a Creation View Controller
        let secondScreenViewController = navigationController.topViewController as! secondScreenViewController
        
        // We set the flashcardsController property to self
        secondScreenViewController.flashcardsController = self
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == false) {
            frontLabel.isHidden = true
        }
        
        else if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
}

