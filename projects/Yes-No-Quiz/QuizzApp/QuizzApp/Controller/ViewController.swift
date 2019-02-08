//
//  ViewController.swift
//  QuizzApp
//
//  Created by Gianmarco Giretti on 20.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlet
    //Mit der Hilfe von Marks kann man in der oberen Leiste besser nach Abschnitten suchen
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    //Hier oben wurden die Verknüpfungen zwischen dem Main und der View erstellt.
    
    //var - let
    let allQuestion = QuestionBank()
    //Eine Konstante - Objekt wird von der QuestionBank erstellt, in der sich die Fragen befinden
    var pickedAnswer = false;
    //Die Frage wird zu Beginn zuerst einmal auf false gestellt.
    var questionNumber = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let firstQuestion = allQuestion.questionList[0]
        //Es wird eine Konstante erstellt, die die erste Frage der questionList beinhaltet.
        questionLabel.text = firstQuestion.questionText
        //Dem questionLabel Fragefeld/Textfeld wird die erste Frage zugeteilt
    }

    // MARK: - Action (+ bei button für beide)
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        if sender.tag == 1 {
            pickedAnswer = true
            //Die Buttons bekommen tags zugeteilt, damit man die Buttons identifizieren kann.
    }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        //Nach jeder Frage wird questionNumber um eins erhöht, damit man zur nächsten Frage gelangt.
        
        nextQuestion()
    }
    
    
    // MARK: - Methods

    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        //Da Label ein Text ist muss man eine String Interpretation machen
        progressLabel.text = "\(questionNumber + 1) / 3"
        //Das progressLabel bekommt mit jdem updateUI() die nächste Zahl als Anzeige, wenn eine Frage beantwortet ist.
        
        progressBarView.frame.size.width = (self.view.frame.width / 3) * CGFloat (questionNumber + 1)
        //Hier bekommt die progressBarView ihre größe zugeteilt. Also dem dynmaischen Strich in der progressBarView bekommt jede runde eine neue Anzeige größe
    }
    
    func nextQuestion() {
        if questionNumber <= 2 {
            //Diese Funktion dient dazu, dass kein Index Overflow passieren kann. Es wird hier dafür gesorgt, dass man max 3 Fragen stellen kann (Da das Fragen Array eine größe von 3 hat).
            questionLabel.text = allQuestion.questionList[questionNumber].questionText
            //Diese Zuweisung ist für das wechseln der Textfrage zuständig. Es wird hier jedes Allray durchgegangen.
            updateUI()
            
        }
        else {
            print("Quizz finished")
            let alert = UIAlertController(title: "Glückwunsch", message: "Neustart ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Neustart ?", style: .default) {
                (UIAlertAction) in self.restart()
                //Konstanten die nach dem Neustart fragen, wenn das Spiel vorbei ist.
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            //Das alert Objekt hier ist für das Pop-up Fenster zuständig
        }
        
    }
    
    func checkAnswer() {
        
        let correctAnswer = allQuestion.questionList[questionNumber].answer
        //Die Konstante correctAnswer bekommt erstmal einen Boolean Wert zugewiesen. (answer aus der Question Klasse)
        
        if correctAnswer == pickedAnswer {
            print("true")
            score = score + 20
            ProgressHUD.showSuccess("Richtig")
            //Ist das Fenster welches den Haken anzeigt (Installationsbeschreibung im README.md)
        }
        else{
            print("false")
            ProgressHUD.showError("Falsch")
             //Ist das Fenster welches das Kreuz anzeigt (Installationsbeschreibung im README.md)
        }
        
    }
    
    func restart() {
        questionNumber = 0
        score = 0
        nextQuestion()
        
        //Alle Werte werden zurückgesetzt, damit das Spiel neu von 0 aus beginnen kann. Mit nextQuestion wird dann direkt zur ersten Frage gegangen.
    }

}

