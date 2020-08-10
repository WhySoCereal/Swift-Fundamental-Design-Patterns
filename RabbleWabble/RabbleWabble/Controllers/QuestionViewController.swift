//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Brian Alldred on 08/08/2020.
//  Copyright © 2020 Brian Alldred. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
// MARK: - Instance Properties
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    // a computed property
    // Check isViewLoaded so the view is not loaded unintentionally by accessing this property
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    
// MARK: - VIEW LIFECYCLE
    public override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
    }
    
// MARK: - ACTIONS
    
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
        
    }

    @IBAction func handleCorrect(_ sender: Any) { correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) { incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            // TODO: - Handle this...!
            return
        }
        showQuestion()
    }
}



