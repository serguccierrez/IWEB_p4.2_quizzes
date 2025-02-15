//
//  SettingView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 24/11/24.
//

import SwiftUI // Importa la librería SwiftUI para crear interfaces de usuario

//-------------------------------[SettingsView]----------------------------------------

struct SettingsView: View { // Define una vista llamada `SettingsView` que implementa el protocolo `View`
    @Binding var correctAnswers: Set<Int> // Referencia vinculada al conjunto de respuestas correctas que se comparte con otras vistas
    @Binding var counter: Int // Referencia vinculada al contador de récords

    var body: some View { // Define el contenido visual de la vista
        VStack(spacing: 20) { // Organiza los elementos verticalmente con un espaciado de 20 puntos

            //-------------------------------[ResetCorrectAnswersButton]----------------------------------------

            Button(action: { // Botón con una acción asociada
                correctAnswers.removeAll() // Elimina todas las respuestas correctas
            }) {
                Text("Reiniciar completados") // Etiqueta del botón
                    .foregroundColor(.white) // Cambia el color del texto a blanco
                    .padding() // Agrega espacio interno al botón
                    .frame(maxWidth: .infinity) // Hace que el botón ocupe todo el ancho disponible
                    .background(Color.red) // Define un fondo rojo para el botón
                    .cornerRadius(10) // Aplica bordes redondeados al botón
            }
            .padding() // Agrega espacio alrededor del botón

            //-------------------------------[ResetCounterButton]----------------------------------------

            Button(action: { // Botón con una acción asociada
                counter = 0 // Reinicia el contador a 0
                UserDefaults.standard.set(counter, forKey: "counterKey") // Guarda el contador en UserDefaults
            }) {
                Text("Reiniciar récord") // Etiqueta del botón
                    .foregroundColor(.white) // Cambia el color del texto a blanco
                    .padding() // Agrega espacio interno al botón
                    .frame(maxWidth: .infinity) // Hace que el botón ocupe todo el ancho disponible
                    .background(Color.red) // Define un fondo rojo para el botón
                    .cornerRadius(10) // Aplica bordes redondeados al botón
            }
            .padding() // Agrega espacio alrededor del botón

            Spacer() // Agrega un espacio flexible para empujar los elementos hacia arriba
        }
        .padding() // Agrega espacio interno a todo el contenido del VStack
        .navigationTitle("Ajustes") // Establece el título de navegación de la barra superior
    }
}

//-------------------------------[Preview]----------------------------------------

#Preview {
    SettingsView(correctAnswers: .constant(Set<Int>()), counter: .constant(0))
}
