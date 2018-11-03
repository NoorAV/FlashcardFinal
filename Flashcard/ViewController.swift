//
//  ViewController.swift
//  Flashcard
//
//  Created by Noor Amir Virani on 11/2/18.
//  Copyright © 2018 Noor Amir Virani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    

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
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false
        }
        else
        {
            frontLabel.isHidden = true
        }
        
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
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
    }
    

}

