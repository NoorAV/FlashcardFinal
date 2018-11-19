//
//  CreationViewController.swift
//  Flashcard
//
//  Created by Noor Amir Virani on 11/2/18.
//  Copyright © 2018 Noor Amir Virani. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var btnOption1TextField: UITextField!
    @IBOutlet weak var btnOption3TextField: UITextField!
    
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text  = initialAnswer
        
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let extraAnswer1Text = btnOption1TextField.text
        
        let extraAnswer2Text = btnOption3TextField.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty
        {
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            present(alert, animated: true)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            
        }
        else
        {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer1: extraAnswer1Text!, extraAnswer2: extraAnswer2Text!)
            dismiss(animated: true)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
