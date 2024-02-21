//
//  IngredientModel.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 07/02/24.
//

import Foundation

struct Ingredient: Hashable {
    let name: String
    let picture: String
    let isCorrect: Bool
    var isClicked = false
}
