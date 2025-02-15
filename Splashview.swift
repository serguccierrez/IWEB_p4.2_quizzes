//
//  Splashview.swift
//  P4-IWEB
//
//  Created by labditmacvm on 2/12/24.
//

import SwiftUI // Importa la librería SwiftUI para crear interfaces de usuario

//-------------------------------[Splashview]----------------------------------------

struct Splashview: View { // Define una estructura llamada `Splashview` que implementa el protocolo View
    @State private var SlashNotActive = false // Declara una variable de estado para controlar si la vista de inicio debe mostrarse o no
    
    var body: some View { // Define el contenido visual de la pantalla
        if SlashNotActive { // Comprueba si `SlashNotActive` es true
            HomeScreenView() // Si es true, muestra la vista de inicio `HomeScreenView`
        } else { // Si no, muestra la pantalla de splash
            VStack { // Organiza los elementos verticalmente
                Image("Icono") // Muestra una imagen llamada "Icono" que debe estar en los recursos del proyecto
                    .padding(.top, 225) // Agrega espacio en la parte superior
                Text("Quiz App") // Muestra el nombre de la aplicación
                    .font(.system(size: 30)) // Establece una fuente personalizada con tamaño 30
                Spacer() // Agrega un espacio flexible para separar los elementos
                Text("IWEB-2024") // Muestra un texto con el año y contexto de la aplicación
                    .foregroundColor(.gray) // Cambia el color del texto a gris
            }
            .onAppear { // Define una acción que ocurre cuando esta vista aparece
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Ejecuta un bloque de código después de 2 segundos
                    withAnimation { // Aplica una animación a los cambios de estado
                        self.SlashNotActive = true // Cambia `SlashNotActive` a true para mostrar la vista de inicio
                    }
                }
            }
        }
    }
}

//-------------------------------[Preview]----------------------------------------

#Preview {
    Splashview()
}
