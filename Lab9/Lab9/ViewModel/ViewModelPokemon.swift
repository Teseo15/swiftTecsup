//
//  ViewModelPokemon.swift
//  Lab9
//
//  Created by MAC05 on 17/10/21.
//

import Foundation

class ViewModelPokemon{
    var refreshData = {
        () -> () in
    }
    var dataArrayPokemonList: [ListPokemon] = []{
        didSet{
            refreshData()
        }
    }

    
    func getListPokemon(){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {return}
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return}
            
            do{
                let resultApi = try JSONDecoder().decode(Pokedex.self, from: data)
                print("Resultados de api",type(of: resultApi))
                var contador :Int = 0
                var indice:String = "0"
                var sub:String
                for pokemon in resultApi.results{
                    contador += 1
                    sub = String(format: "%002d", contador)
                    indice = "\(indice)\(sub)"
                    print("nombre: ",pokemon.name,"indice",indice)
                    
                    indice = "0"
                    self.dataArrayPokemonList.append(pokemon)
                }
            }catch let error as NSError{
                print("error 31",error)
            }
        }.resume()
                
    }
}
