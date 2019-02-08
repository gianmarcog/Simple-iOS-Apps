//
//  QuestionBank.swift
//  QuizzApp
//
//  Created by Gianmarco Giretti on 20.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var questionList = [Question]()
    //questionList ist vom Typ "Array". questionList beinhaltet alle Objekte vom Objekt Question. Ziel ist es hierbei, dass sobald ein Objekt von Questionbank gemacht wird, soll das Array sofort mit den Fragen befüllt werdem und man mittels dem Punktoperator auf die einzelnen Fragen drauf zugreifen kann.
    
    init() {
        //Fragen Objekte von questionList
        let question1 = Question(text: "1 * 1 = 1 ?", correctAnswer: true)
        let question2 = Question(text: "5 - 5 = 1", correctAnswer: false)
        let question3 = Question(text: "0 * 0 = 0", correctAnswer: true)
        
        //Fragen in die ArrayList hinzufügen
        questionList.append(question1)
        questionList.append(question2)
        questionList.append(question3)

    }
}
