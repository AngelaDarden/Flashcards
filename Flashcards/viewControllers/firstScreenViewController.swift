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
    var answer2: String
    var answer3: String
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
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetButton2: UIButton!
    
    @IBOutlet weak var ScoreKeeperLabel: UILabel!
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    // For the previous button animation
    var didTapOnPrev = false
    
    // Button to remember what the correct answer is
    var correctAnswerButton: UIButton!
    
    // Adding the counter
    var ScoreKeeper = 0
    
    // Array to hold scores
    var scores = [Int]()
    
    
    
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
        resetButton.layer.cornerRadius = 20.0
        resetButton2.layer.cornerRadius = 20.0
        
        // Borders
        // Color box shows with "= Color Literal"
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        resetButton.layer.borderWidth = 3.0
        resetButton.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        resetButton2.layer.borderWidth = 3.0
        resetButton2.layer.borderColor = #colorLiteral(red: 0.7188917994, green: 0.2311008573, blue: 0.9843792319, alpha: 1)
        
        // Read saved flashcards
        readSavedFlashcards()
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        
    } // End of viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // For the flashcard
        // First start with the flashcard invisible and slightly smaller in size
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
        
        //For the multiple choice buttons
        
        // Button One
        btnOptionOne.alpha = 0.0
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionOne.alpha = 1.0
            self.btnOptionOne.transform = CGAffineTransform.identity
        })
        
        // Button Two
        btnOptionTwo.alpha = 0.0
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionTwo.transform = CGAffineTransform.identity
        })
        
        // Button Three
        btnOptionThree.alpha = 0.0
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionThree.alpha = 1.0
            self.btnOptionThree.transform = CGAffineTransform.identity
        })
        
        // Reset Button
        resetButton.alpha = 0.0
        resetButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.resetButton.alpha = 1.0
            self.resetButton.transform = CGAffineTransform.identity
        })
        
        // Reset for Option One
        resetButton2.alpha = 0.0
        resetButton2.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.resetButton2.alpha = 1.0
            self.resetButton2.transform = CGAffineTransform.identity
        })
        
    } // End of viewWillAppear()
    
    override func viewDidAppear(_ animated: Bool)
    {
        if flashcards.count == 0
        {
            //updateFlashcard(question: "What's the capital of Brasil?", answer: "Brasilia", extraAnswerOne: "Santiago", extraAnswerTwo: "Buenos Aires", isExisting: false)
            performSegue(withIdentifier: "newFlashcard", sender: self)
            print("Flashcard0")
        }
        
        else
        {
            updateLabels()
            updateNextPrevButtons()
            print("Flashcard1")
        }
    } // End of viewDidAppear()
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // We know the destinataion of the segue is in the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let secondScreenViewController = navigationController.topViewController as! secondScreenViewController
        
        
        if (segue.identifier == "EditSegue"){
            secondScreenViewController.initialQuestion = frontLabel.text
            secondScreenViewController.initialAnswer = backLabel.text
        }
        
        // We set the flashcardsController property to self
        secondScreenViewController.flashcardsController = self
    } // End of prepare()
    
    @IBAction func didTapOnFlashcard(_ sender: Any)
    {
        flipFlashcard()
    } // End of didTapOnFlashcard()
    
    func flipFlashcard()
    {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
        
        
        if (frontLabel.isHidden == false)
        {
            frontLabel.isHidden = true
        }
        
        else if (frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false
        }
    } // End of flipFlashcard()
    
    func animateCardOut()
    {
        if (didTapOnPrev == false){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        })
        } // end of if statement
        
        else{
            UIView.animate(withDuration: 0.3){
                self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            } completion: { finished in
            self.updateLabels()
            self.animateCardIn()
            }
        } // end of else statement

    } // end of animateCardOut
    
    func animateCardIn()
    {
        if (didTapOnPrev == false){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)

            UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
            }
            
        }// end of if statement
        
        else
        {
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            UIView.animate(withDuration: 0.3) { self.card.transform = CGAffineTransform.identity}
        } // end of else statement
        didTapOnPrev = false
        
    } // end animateCardIn
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, isExisting: Bool)
    {
        let flashcard = Flashcard(question: question, answer: answer, answer2: extraAnswerOne, answer3: extraAnswerTwo)
        
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        
        if isExisting
        {
            // Replace existing flashcard
            flashcards[currentIndex] = flashcard
        }
        
        else
        {
            // Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            // Logging to the console
            print("Added new flashcard :)")
            print("We now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Saving
        saveAllFlashcardsToDisk()
    } // End of updateFlashcard()
    
    
    @IBAction func didTapOnReset(_ sender: Any)
    {
        frontLabel.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
        resetButton.isHidden = true
        resetButton2.isHidden = true
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any)
    {
        if btnOptionOne == correctAnswerButton
        {
            flipFlashcard()
            frontLabel.isHidden = true
            btnOptionTwo.isHidden = true
            btnOptionThree.isHidden = true
            resetButton.isHidden = false
            ScoreKeeper += 1
            ScoreKeeperLabel.text = "Score: \(ScoreKeeper) / \(currentIndex+1)"
            scores.append(ScoreKeeper)
            print("Scores Array:  \(scores)")
        }
        else
        {
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = true
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any)
    {
        if btnOptionTwo == correctAnswerButton
        {
            flipFlashcard()
            frontLabel.isHidden = true
            btnOptionOne.isHidden = true
            btnOptionThree.isHidden = true
            resetButton.isHidden = false
            ScoreKeeper += 1
            ScoreKeeperLabel.text = "Score: \(ScoreKeeper) / \(currentIndex+1)"
            scores.append(ScoreKeeper)
            print("Scores Array:  \(scores)")
        }
        else
        {
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = true
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any)
    {
        if btnOptionThree == correctAnswerButton
        {
            flipFlashcard()
            frontLabel.isHidden = true
            btnOptionOne.isHidden = true
            btnOptionTwo.isHidden = true
            resetButton.isHidden = true
            resetButton2.isHidden = false
            ScoreKeeper += 1
            ScoreKeeperLabel.text = "Score: \(ScoreKeeper) / \(currentIndex+1)"
            scores.append(ScoreKeeper)
            print("Scores Array:  \(scores)")
        }
        else
        {
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = true
        }
    }
    
    @IBAction func didTapOnPrev(_ sender: Any)
    {
        didTapOnPrev = true
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        //updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
       
        animateCardIn()
        
        updateLabels()
    } // End of didTapOnPrev()
    
    @IBAction func didTapOnNext(_ sender: Any)
    {
        
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        //updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        animateCardOut()
    } // End of didTapOnNext()
    
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
    } // End of updateNextPrevButtons()
    
    func updateLabels()
    {
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        // Update buttons
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.answer2, currentFlashcard.answer3].shuffled()
        
        // Iterate over both arrays at the same time
        for (button, answer) in zip(buttons, answers)
        {
            // Set the title of this random button, with a random answer
            button?.setTitle(answer, for: .normal)
            
            // If this is the correct answer save the button
            if answer == currentFlashcard.answer
            {
                correctAnswerButton = button
            } // End of if statement
        } // End of for loop
        
    } // End of updateLabels()
    
    func saveAllFlashcardsToDisk()
    {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "answer2": card.answer2, "answer3": card.answer3]
        }
        
        // Save array to disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        print("Flashcards saved to UserDefaults")
       
    } // End of saveAllFlashcardsToDisk()
    
    
    func saveScoresToDisk()
    {
        // Saving scores
        scores = UserDefaults.standard.array(forKey: "SavingScores") as? [Int] ?? []
        
        // Saving scores array to disk using UserDefaults
        UserDefaults.standard.set(scores, forKey: "SavedScores")
        
        // Logging the saved scores
        print("Scores saved to UserDefaults")
        
    } // End of saveScoresToDisk()
    
    /*func readSavedScores()
    {
        let savedScores = UserDefaults.standard.array(forKey: "SavedScores") as? [Int] ?? []
    } // End of readSavedScores()*/
    
    func readSavedFlashcards()
    {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            
            // In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map
            { (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"] ?? "Question", answer: dictionary["answer"] ?? "Answer", answer2: dictionary["answer2"] ?? "Answer2", answer3: dictionary["answer3"] ?? "Answer3")
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
            
        }
    } // End of readSavedFlashcards()
    
    
    
    @IBAction func didTapOnDelete(_ sender: Any)
    {
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
        { action in
            self.deleteCurrentFlashcard()
        }
        
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    } // End of didTapOnDelete()
    
    func deleteCurrentFlashcard()
    {
        // Delete current
        flashcards.remove(at: currentIndex)
        
        // Specual case: Check if last card was deleted
        if currentIndex > flashcards.count - 1
        {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    } // End of deleteCurrentFlahcard()
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
} // End of firstScreenViewController

