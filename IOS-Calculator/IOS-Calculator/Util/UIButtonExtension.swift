//
//  UIButtonExtension.swift
//  IOS-Calculator
//
//  Created by Laureano Velasco on 08/03/2023.
//

import UIKit
private let indigo = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)


extension UIButton {
    // Borde redondo
        func round() {
            layer.cornerRadius = bounds.height / 2
            clipsToBounds = true
        }
    //brillar
    func shine() {
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 0.5
            }) { ( completion ) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.alpha = 1
                })
            }
        }
    
    // apariencia de seleccion de botones de operacion
    //Anule esta funcion debido a que no funcionaba adecuadamente
    //esta funcion hace que al seleccionar un boton de +-X/ muestre que esta seleccionado con la
    //inversion de los colores
    // para probarla solo descomentarla y los llamados en cada parte del codigo
    //señalada con un //FUNCION ANULADA
    
   /* func selectOperation(_ selected: Bool) {
        
        backgroundColor = selected ? .white : indigo
        setTitleColor(selected ? indigo : .white, for: .normal)
    }*/

}
