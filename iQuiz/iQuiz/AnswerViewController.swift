//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Phoebe Hu on 2/20/19.
//  Copyright © 2019 Phoebe Hu. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var quizProcess: Int = 0
    var quizQuestions: [QuizQuestion]? = nil
    var quizQuestion: QuizQuestion? = nil
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestions = UIApplication.shared.quizQuestionRepository.getQuizQuestions()
        quizQuestion = quizQuestions?[quizProcess]
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

        questionLabel.text = quizQuestion?.question
        answerLabel.setTitle(quizQuestion?.options[(quizQuestion?.answer)!], for: .normal)
        if (quizQuestion?.correct)! {
            resultLabel.text = "Great!"
        } else {
            resultLabel.text = "Oops..."
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        goToNext()
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        goToHome()
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        goToNext()
    }
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        goToHome()
    }
    
    func goToHome() {
        let alertController = UIAlertController(title: "Warning", message: "Are you sure that you want to quit the quiz?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive, handler: {(alert: UIAlertAction!) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: false)
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(quitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func goToNext() {
        if quizProcess < ((quizQuestions?.count)! - 1) { // not yet finished
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"QuestionViewController") as! QuestionViewController
            vc.quizProcess = quizProcess + 1
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"FinishedViewController") as! FinishedViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
