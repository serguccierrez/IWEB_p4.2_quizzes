//
//  ContentView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 13/11/24.
//

import SwiftUI

//-------------------------------[HomeScreenView]----------------------------------------

struct HomeScreenView: View {
    // Obtiene la clase de tamaño vertical del entorno (compacto o regular), útil para adaptar la interfaz a la orientación del dispositivo.
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    // Variable de estado que rastrea las respuestas correctas como un conjunto de IDs de cuestionarios.
    @State private var correctAnswers: Set<Int> = []
    
    // Variable de estado para rastrear si los cuestionarios se han cargado.
    @State private var quizzesLoaded = false
    
    var body: some View {
        
        // Comprueba si el dispositivo está en orientación horizontal.
        if verticalSizeClass == .compact {
            NavigationStack { // Contenedor de navegación para gestionar transiciones entre vistas.
                
                HStack { // Contenedor horizontal.
                    
                    VStack { // Contenedor vertical.
                        
                        Text("Quizzes") // Título principal.
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal, 130)
                            .padding(.top, 50)
                        
                        Text("¡Demuestra lo que sabes!") // Subtítulo.
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 90)
                        
                        Spacer() // Agrega un espacio flexible entre elementos.
                        
                        // Enlace de navegación que lleva a la vista `QuizListView`.
                        NavigationLink(
                            destination: QuizListView(
                                correctAnswers: $correctAnswers, quizzesLoaded: $quizzesLoaded
                            )
                        ) {
                            // Botón personalizado.
                            OptionButton(title: "Jugar", SystemIconName: "play")
                        }
                        .padding() // Espaciado adicional alrededor del botón.
                        
                        Spacer()
                        
                        Text("Desarrollado por Sergio, Álvaro y Patricia") // Texto de pie de página.
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 80)
                    }
                    .padding() // Agrega espaciado alrededor de todo el contenedor vertical.
                    
                    Spacer()
                    
                    // Icono de signo de interrogación, representado como una imagen del sistema.
                    Image(systemName: "questionmark")
                        .resizable()
                        .padding(.trailing, 70)
                        .frame(width: 300, height: 300)
                }
            }
        } else { // Si el dispositivo está en orientación vertical.
            
            VStack { // Contenedor vertical.
                
                NavigationStack {
                    
                    Text("Quizzes") // Título principal.
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                    
                    Text("¡Demuestra lo que sabes!") // Subtítulo.
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Icono de signo de interrogación.
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 200, height: 300)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    // Enlace de navegación a `QuizListView`.
                    NavigationLink(
                        destination: QuizListView(
                            correctAnswers: $correctAnswers, quizzesLoaded: $quizzesLoaded
                        )
                    ) {
                        OptionButton(title: "Jugar", SystemIconName: "play") // Botón personalizado.
                    }
                    
                    Spacer()
                    
                    Text("Desarrollado por Sergio, Álvaro y Patricia") // Texto de pie de página.
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

//-------------------------------[OptionButton]----------------------------------------

struct OptionButton: View {
    // Título del botón.
    var title: String
    // Nombre del icono del sistema que se mostrará en el botón.
    var SystemIconName: String
    
    var body: some View {
        HStack { // Contenedor horizontal para el icono y el texto.
            
            Spacer() // Espacio flexible antes del contenido.
            
            Image(systemName: SystemIconName) // Icono del sistema.
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(title) // Texto del botón.
                .font(.headline)
            
            Spacer() // Espacio flexible después del contenido.
        }
        .padding(10) // Espaciado interno.
        .background( // Fondo del botón.
            RoundedRectangle(cornerRadius: 5) // Rectángulo con bordes redondeados.
                .stroke(Color.blue) // Borde azul.
        )
        .padding(.horizontal, 40) // Espaciado horizontal alrededor del botón.
    }
}

//-------------------------------[Preview]----------------------------------------

#Preview {
    HomeScreenView()
}
