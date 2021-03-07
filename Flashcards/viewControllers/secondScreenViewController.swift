//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Angela Darden on 3/6/21.
//

import UIKit

class secondScreenViewController: UIViewController {

    var flashcardsController: firstScreenViewController!
    
    @IBOutlet var questionTextField: UITextField!
    @IBOutlet var answerTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
    dismiss(animated: true)
    
    }

    @IBAction func didTapOnDone(_ sender: Any) {
    
        // Get the text in the question text field
        let questionText = questionTextField.text
        
        // Get the text in the answer text field
        let answerText = answerTextField.text
        
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        // Dismiss
        dismiss(animated: true)
    }
}
