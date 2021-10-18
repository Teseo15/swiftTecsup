//
//  Pokedex.swift
//  Lab9
//
//  Created by MAC05 on 17/10/21.
//

import Foundation

struct Pokedex: Codable{
    let count : Int
    let results : [ListPokemon]
}
