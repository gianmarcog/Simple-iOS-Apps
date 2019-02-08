//
//  Question.swift
//  QuizzAppMC
//
//  Created by Gianmarco Giretti on 21.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let correctAnswer: Int
    
    init(questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, answer: Int){
        //Die Init Funktion ist in anderen Programmiersprachen besser bekannt als Konstruktor. Hier wird es benötigt, da man den Variablen/Konstanten keine Werte zuweist. Hier wird das Gerüßt für das questionLabel gebaut.
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        correctAnswer = answer
    }
}
