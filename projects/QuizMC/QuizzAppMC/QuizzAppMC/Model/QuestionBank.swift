//
//  QuestionBank.swift
//  QuizzAppMC
//
//  Created by Gianmarco Giretti on 21.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var list = [Question]()
    //Es wird ein Objekt von der Question.swift Klasse angelegt.
    
    init(){
        //Jetzt kann man mit der erstellten init()-Methode (Konstruktor) von der QuestionBank Klasse arbeiten.
        list.append(Question(questionText: "Marco seine lieblings Serie ?", choiceA: "Friends", choiceB: "Scrubs", choiceC: "The Big Bang Theory", choiceD: "Alle drei", answer: 4))
        
        list.append(Question(questionText: "Marco sein lieblings Getränk ?", choiceA: "Volvic Wasser", choiceB: "Coca Cola", choiceC: "Monster Energy", choiceD: "Ficken", answer: 3))
        //Hier wird der Question Klasse, dadurch dass man ein Objekt davon erzeugt via den .-Operator eine Frage angehängt (append)
    }
}
