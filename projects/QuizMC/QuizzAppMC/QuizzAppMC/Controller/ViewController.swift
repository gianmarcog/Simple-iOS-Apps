//
//  ViewController.swift
//  QuizzAppMC
//
//  Created by Gianmarco Giretti on 21.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    //Das sind die Verknüpfungen zwischen View/Label und dem Controller (ViewController)
    
    //Outlet for Buttons
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!    
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    //Das sind die Verknüpfungen zwischen den Buttons und dem Controller (ViewController)
    
    let allQuestion = QuestionBank()
    //Wird ein Objekt von der Questionbank erstellt, da man auf diese später zugreifen muss
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestion()
        updateUI()
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        
        if sender.tag == selectedAnswer {
            HUD.flash(.success)
            //Die HUD Anzeige, wenn etwas richtig ist
            score += 1
        }
        else{
            HUD.flash(.error, delay: 0.5)
            //Die HUD Anzeige wenn etwas falsch ist
        }
        questionNumber += 1
        updateQuestion()
        //Hier wird die questionNumber hochgezählt und geupdated, dass nach dem drücken des Buttons die nächste Frage erscheint
    }
    
    func updateQuestion() {
        
        if questionNumber <= allQuestion.list.count - 1 {
            //Das hier ist wieder zum Schutz dafür, dass kein Index Overflow passiert
            questionLabel.text = allQuestion.list[questionNumber].question
            //Der questionLabel.text bekommt nun für jede Runde eine neue Frage, da man mittels list[questionNumber] das Array der QuestionBank durchgeht (deshalb wird die questionNumber nach jeder Runde hochgezählt). und das .question sorgt dann dafür dass der Text an der Stelle auf der GUI ausgegeben wird.
            optionA.setTitle(allQuestion.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestion.list[questionNumber].optionB, for: UIControl.State.normal)
            //UIControl(Touchereignissesteuern/verfolgen).State(Der Button kann unterschiedliche eigenschaften haben).normal(der Buttomn ist aktiv) Im Grunde bedeuten diese setTitle, dass sie unterschiedliche Eingeschaften haben können bzw. man die Eigenschaften ändern kann. In diesem Fall, dass sich der Text im Button ändert.              (Funktioniert nur für IBOutlets und nicht für IBActions)
            optionC.setTitle(allQuestion.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestion.list[questionNumber].optionD, for: UIControl.State.normal)
            selectedAnswer = allQuestion.list[questionNumber].correctAnswer
            //Hier wird die Ausgewählte Antwort gecheckt ob sie richtig ist indem man die Int Zahl checkt. (In der Main haben wir jedem der einzelnen Button eine Tag nummer gegeben um sie zu unterscheiden.
            updateUI()
            //Wird nach jeder Frage aufgerufen. Also mit jeder Neuen Frage gibt es das neue "Update damit es angezeigt wird"
        }
        else{
            let alert = UIAlertController(title: "Awesome", message: "End of Quizz. Do you want to start over ?", preferredStyle: .alert)
            //Wenn man alle Fragen durch hat taucht dann dieser Text als alarm auf (Das Pop up).
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restartQuiz()})
            alert.addAction(restartAction)
            //Hier bekommt der "Restart" Button seine Logik,dass er beim berühren neustarten soll.
            present(alert, animated: true, completion: nil)
            //Ohne das Aufrufen von present taucht das pop up (sofern man alert gewählt hat) gar nicht erst auf. Also ein muss wenn man das Pop up haben will.
        }
        
    }
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        //Zeigt den Score an den man momentan hat
        
        questionCounter.text = "\(questionNumber + 1)/\(allQuestion.list.count)"
        //Der Fragen/Antwort Counter wird ebenfalls neu "geupdated"
        progressView.frame.size.width = (view.frame.size.width / CGFloat(allQuestion.list.count)) * CGFloat(questionNumber + 1)
        //Hier wird dann die progressView "geupdatet"
    }
    
    func restartQuiz(){
        score = 0
        questionNumber = 0
        updateQuestion()
        //Diese FUnktion setzt alles zurück und lässt das Spiel von vorne beginnen.
    }
    
}

