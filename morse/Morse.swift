//
//  Morse.swift
//  morse
//
//  Created by Ilias Ennmouri on 27.03.17.
//  Copyright © 2017 Ilias Ennmouri. All rights reserved.
//

import Foundation

let alphaToMorse = [
    "A": ".-",
    "B": "-...",
    "C": "-.-.",
    "D": "-..",
    "E": ".",
    "F": "..-.",
    "G": "--.",
    "H": "....",
    "I": "..",
    "J": ".---",
    "K": "-.-",
    "L": ".-..",
    "M": "--",
    "N": "-.",
    "O": "---",
    "P": ".--.",
    "Q": "--.-",
    "R": ".-.",
    "S": "...",
    "T": "-",
    "U": "..-",
    "V": "...-",
    "W": ".--",
    "X": "-..-",
    "Y": "-.--",
    "Z": "--..",
    "a": ".-",
    "b": "-...",
    "c": "-.-.",
    "d": "-..",
    "e": ".",
    "f": "..-.",
    "g": "--.",
    "h": "....",
    "i": "..",
    "j": ".---",
    "k": "-.-",
    "l": ".-..",
    "m": "--",
    "n": "-.",
    "o": "---",
    "p": ".--.",
    "q": "--.-",
    "r": ".-.",
    "s": "...",
    "t": "-",
    "u": "..-",
    "v": "...-",
    "w": ".--",
    "x": "-..-",
    "y": "-.--",
    "z": "--..",
    "1": ".----",
    "2": "..---",
    "3": "...--",
    "4": "....-",
    "5": ".....",
    "6": "-....",
    "7": "--...",
    "8": "---..",
    "9": "----.",
    "0": "-----",
    " ": "/",
    "@": "@"
]

func convertLetterToMorse(input: Character) -> String {
    var returnChar = alphaToMorse[String(input)]
    if returnChar == nil {
        returnChar = ""
    }
    return returnChar!
}

func convertStringToMorse(input: String) -> String {
    let stringToConvert = input
    var returnString = ""
    for char in stringToConvert.characters {
        let returnChar = convertLetterToMorse(input: char)
        if returnChar != "" {
            returnString += returnChar + " "
        }
    }
    return returnString
}
