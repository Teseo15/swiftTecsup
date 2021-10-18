//
//  PokeApiViewController.swift
//  Lab9
//
//  Created by MAC05 on 17/10/21.
//

import UIKit

class PokeApiViewController: UIViewController {

    @IBOutlet weak var pokeImagen: UIImageView!
    @IBOutlet weak var pokelistPicker: UIPickerView!
    @IBOutlet weak var poketextField: UITextField!
    
    var viewPokeModel = ViewModelPokemon()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        bind()
        setUpTextField()
        var enlace : String = "https://static.wikia.nocookie.net/estrategiaspokemon/images/9/95/Charizard.png/revision/latest?cb=20151022213439&path-prefix=es"
        let urlImage = URL(string: enlace)
         
         let data = try? Data(contentsOf: urlImage!)
         
         if let imageData = data {
             pokeImagen.image = UIImage(data: imageData)
          }
    }
    
    func setupPicker(){
        viewPokeModel.getListPokemon()
    pokelistPicker.delegate = self
    pokelistPicker.dataSource = self
    }
    func setUpTextField(){
    poketextField.delegate = self
    poketextField.inputView = pokelistPicker
    }

    func bind() {
        viewPokeModel.refreshData = {
            [weak self] () in DispatchQueue.main.async {
                self?.pokelistPicker.isHidden = true
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PokeApiViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewPokeModel.dataArrayPokemonList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewPokeModel.dataArrayPokemonList[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        poketextField.text = viewPokeModel.dataArrayPokemonList[row].name
        
        pokelistPicker.backgroundColor = UIColor.white
        pokelistPicker.isHidden = true
        var contador :Int = row + 1
        var sub = String(format: "%002d", contador)
        print("esto es pickerView", contador)
        
        var indice :String = "0"
        indice = "\(indice)\(sub)"
        print("ahora",indice)
        var enlace : String = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(indice).png"
        print(enlace)

      /*  let urlImage = URL(string: enlace)
        
        let data = try? Data(contentsOf: urlImage!)
        
        if let imageData = data {
            pokeImagen.image = UIImage(data: imageData)
         }
            */
        
    }
}
extension PokeApiViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pokelistPicker.isHidden = false
        return false
    }
}
