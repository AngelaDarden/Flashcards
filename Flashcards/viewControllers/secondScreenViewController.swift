//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Angela Darden on 3/6/21.
//

import UIKit

class secondScreenViewController: UIViewController
{

    var flashcardsController: firstScreenViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any)
    {
    dismiss(animated: true)
    
    }

    @IBAction func didTapOnDone(_ sender: Any)
    {
    
        // Get the text in the question text field
        let questionText = questionTextField.text
        
        // Get the text in the answer text field
        let answerText = answerTextField.text
        
        // Get the text in the second answer text field
        let extraAnswerOneText = extraAnswerOneTextField.text
        
        // Get the text in the third answer text field
        let extraAnswerTwoText = extraAnswerTwoTextField.text
        
        // Checking if empty
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty)
        {
            // The alert that displays
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter in a question and an answer", preferredStyle: UIAlertController.Style.alert)
            
            // Okay action that displays with the alert
            let okAction = UIAlertAction(title: "Okay", style: .default)
            
            // Adding the alert
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }
        
        else
        {
            // If the fields aren't missing anything, continue
            // Call the function to update the flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!)
        
        // Dismiss
        dismiss(animated: true)
        }
    }
}
