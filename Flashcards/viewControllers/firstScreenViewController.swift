//
//  ViewController.swift
//  Flashcards
//
//  Created by Angela Darden on 2/20/21.
//

import UIKit

struct Flashcard
{
    var question: String
    var answer: String
}

class firstScreenViewController: UIViewController
{
    
    // front label is the question
    // back label is the answer
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad()
    {
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
  
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding our initial flashcard if needed
        if flashcards.count == 0
        {
            updateFlashcard(question: "What's the capital of Brasil?", answer: "Brasilia", extraAnswerOne: "Santiago", extraAnswerTwo: "Buenos Aires")
        }
        
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // We know the destinataion of the segue is in the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigationo Controller only contains a Creation View Controller
        let secondScreenViewController = navigationController.topViewController as! secondScreenViewController
        
        if (segue.identifier == "EditSegue"){
        secondScreenViewController.initialQuestion = frontLabel.text
        secondScreenViewController.initialAnswer = backLabel.text
        }
        
        // We set the flashcardsController property to self
        secondScreenViewController.flashcardsController = self
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any)
    {
        if (frontLabel.isHidden == false)
        {
            frontLabel.isHidden = true
        }
        
        else if (frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?)
    {
        let flashcard = Flashcard(question: question, answer: answer)
        
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
                
        
        // Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        // Logging to the console
        print("Added new flashcard :)")
        print("We now have \(flashcards.count) flashcards")
        
        // Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Saving
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOptionOne(_ sender: Any)
    {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any)
    {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any)
    {
        btnOptionThree.isHidden = true
    }
    
    @IBAction func didTapOnPrev(_ sender: Any)
    {
     
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any)
    {
        
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons()
    {
        
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        
        else
        {
            nextButton.isEnabled = true
        }
        
        // Disabling prev button if at the beginnning
        if currentIndex == 0
        {
            prevButton.isEnabled = false
        }
        
        else
        {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels()
    {
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk()
    {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        // Save array to disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        print("Flashcards saved to UserDefaults")
        
    }
    
    func readSavedFlashcards()
    {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            
            // In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map
            { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in out flashcards array
            flashcards.append(contentsOf: savedCards)
            
        }
        
    }
    
}

