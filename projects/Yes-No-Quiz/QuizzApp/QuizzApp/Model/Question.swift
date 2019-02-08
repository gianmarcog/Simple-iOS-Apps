//
//  Question.swift
//  QuizzApp
//
//  Created by Gianmarco Giretti on 20.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import Foundation

class Question {
    
    let questionText: String
    let answer: Bool
    
    init(text: String, correctAnswer: Bool) {
        //Macht die Klasse zu einem Objekt
        questionText = text
        answer = correctAnswer
    }
}
