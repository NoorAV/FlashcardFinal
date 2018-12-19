//
//  ViewController.swift
//  Flashcard
//
//  Created by Noor Amir Virani on 11/2/18.
//  Copyright © 2018 Noor Amir Virani. All rights reserved.
//

import UIKit

struct Flashcard
{
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOption1.layer.cornerRadius = 10.0
        btnOption1.clipsToBounds = true
        btnOption2.layer.cornerRadius = 10.0
        btnOption2.clipsToBounds = true
        btnOption3.layer.cornerRadius = 10.0
        btnOption3.clipsToBounds = true
        
        btnOption1.layer.borderWidth = 3.0
        btnOption1.layer.borderColor = #colorLiteral(red: 0, green: 0.8211378455, blue: 0.5715258121, alpha: 1)
        btnOption2.layer.borderWidth = 3.0
        btnOption2.layer.borderColor = #colorLiteral(red: 0, green: 0.8211378455, blue: 0.5715258121, alpha: 1)
        btnOption3.layer.borderWidth = 3.0
        btnOption3.layer.borderColor = #colorLiteral(red: 0, green: 0.8211378455, blue: 0.5715258121, alpha: 1)
        
        readSavedFlashcards()
        
        if flashcards.count == 0{
        
        updateFlashcard(question: "How many letters does the longest word in the English language have?", answer: "45", extraAnswer1: "23", extraAnswer2: "17")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        flipFlashcard()
        
    }
    
    func flipFlashcard(){
        if(frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false
        }
        else
        {
            frontLabel.isHidden = true
        }
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
    }
    
    func animateCardOut(){
        
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrev(){
        
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswer1: String, extraAnswer2: String)
    {
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        btnOption1.setTitle(extraAnswer1, for: .normal)
        btnOption2.setTitle(answer, for: .normal)
        btnOption3.setTitle(extraAnswer2, for: .normal)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons()
    {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question" : card.question, "answer" : card.answer]
        
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcard saved to user defaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as?[[String: String]]{
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapOption1(_ sender: Any) {
        btnOption1.isHidden = true
    }
    
    @IBAction func didTapOption2(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOption3(_ sender: Any) {
        btnOption3.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"
        {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOutPrev()
        
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
    }
    
    func deleteCurrentFlashcard(){
        
    
    }
    
    
    
    

}

