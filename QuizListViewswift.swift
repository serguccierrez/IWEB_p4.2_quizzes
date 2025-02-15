//  QuizzesView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 24/11/24.
//

import SwiftUI

//-------------------------------[QuizListView]----------------------------------------

// Vista principal que muestra la lista de cuestionarios.
struct QuizListView: View {
    
    @State private var model = QuizzesModel() // Declara una variable de estado que contiene el modelo de los quizzes.
    @Binding var correctAnswers: Set<Int> // Vincula un conjunto de identificadores de respuestas correctas que se comparte con otras vistas.
    @State private var favoriteQuizzes: Set<Int> = [] // Variable de estado para almacenar los quizzes marcados como favoritos.
    @Binding var quizzesLoaded: Bool // Vincula un estado compartido que indica si los cuestionarios ya se han cargado.
    @State private var filterOption: QuizFilterOption = .all // Estado para gestionar el filtro seleccionado (todos, acertados, no acertados).
    @State private var counter: Int = 0 // Estado para mostrar el contador de récords.

    var body: some View {
        
        NavigationStack { // Crea un contenedor de navegación.
            
            VStack { // Organiza los elementos verticalmente.
                
                HStack { // Barra de estadísticas mostrada horizontalmente.
                    
                    Text("Completados: \(correctAnswers.count) de \(model.quizzes.count)") // Muestra la cantidad de quizzes completados.
                        .font(.headline) // Aplica una fuente destacada.
                        .foregroundColor(.gray) // Color del texto en gris.
                        .padding(.leading) // Agrega espacio a la izquierda.
                    
                    Spacer() // Agrega un espacio flexible entre elementos.
                    
                    Text("Récord: \(counter)") // Muestra el contador del récord.
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.trailing) // Agrega espacio a la derecha.
                }
                .padding(.bottom, 5) // Espaciado adicional debajo de la barra de estadísticas.
                
                //-------------------------------[Picker]----------------------------------------

                // Picker para seleccionar una opción de filtro (Todos, Acertados, No acertados).
                Picker("Filtrar quizzes", selection: $filterOption) {
                    ForEach(QuizFilterOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option) // Asocia cada opción del enum a un texto.
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // Usa un estilo de selector segmentado.
                .padding(.horizontal) // Agrega espacio horizontal alrededor del Picker.
                
                //-------------------------------[QuizList]----------------------------------------

                // Lista que muestra los quizzes filtrados.
                List(filteredQuizzes(), id: \.id) { quiz in
                    NavigationLink(
                        destination: { QuizzPlayView(quiz: quiz, correctAnswers: $correctAnswers, counter: $counter) } // Navega a la vista de juego del cuestionario seleccionado.
                    ) {
                        QuizListShow(quiz: quiz, favoriteQuizzes: $favoriteQuizzes) // Vista que muestra cada quiz.
                    }
                    .padding(.vertical, 10) // Agrega espacio vertical entre los elementos de la lista.
                }
                .listStyle(PlainListStyle()) // Usa un estilo de lista simple.
            }
            .navigationTitle("Quizzes") // Establece el título de la barra de navegación.
            .toolbar { // Agrega elementos a la barra de herramientas.
                
                // Botón para recargar los cuestionarios.
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            do {
                                try model.getQuizzes() // Intenta descargar los cuestionarios.
                                correctAnswers.removeAll() // Reinicia las respuestas correctas.
                            } catch {
                                print("Error al recargar los cuestionarios") // Manejo básico de errores.
                            }
                        }
                    }) {
                        Text("Recargar") // Texto del botón.
                    }
                }

                // Botón para navegar a la vista de configuración.
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(correctAnswers: $correctAnswers, counter: $counter)) {
                        Image(systemName: "gear") // Icono de engranaje.
                    }
                }
            }
            .onAppear { // Acción que se ejecuta al aparecer la vista.
                Task {
                    if !quizzesLoaded { // Si los cuestionarios no están cargados.
                        do {
                            try model.getQuizzes() // Descarga los cuestionarios.
                        } catch {
                            print("Error al cargar los cuestionarios")
                        }
                        favoriteQuizzes = Set(model.quizzes.filter { $0.favourite }.map { $0.id }) // Sincroniza los favoritos con el modelo.
                        loadCounter() // Carga el contador desde UserDefaults.
                    }
                    quizzesLoaded = true // Marca los cuestionarios como cargados.
                }
            }
        }
    }

    //-------------------------------[FilteredQuizzes]----------------------------------------

    // Filtra los cuestionarios según la opción seleccionada y limita a preguntas de máximo 100 caracteres.
    private func filteredQuizzes() -> [QuizItem] {
        model.quizzes.filter { quiz in
            quiz.question.count <= 100 && // Filtra preguntas <= 100 caracteres.
            (filterOption == .all || // Incluye todos los cuestionarios si el filtro es "Todos".
             (filterOption == .correct && correctAnswers.contains(quiz.id)) || // Filtra los acertados.
             (filterOption == .notCorrect && !correctAnswers.contains(quiz.id))) // Filtra los no acertados.
        }
    }
    
    //-------------------------------[LoadCounter]----------------------------------------

    // Carga el contador del récord desde UserDefaults.
    private func loadCounter() {
        counter = UserDefaults.standard.integer(forKey: "counterKey")
    }
}

//-------------------------------[QuizListShow]----------------------------------------

// Vista que representa un cuestionario en la lista.
struct QuizListShow: View {
    
    let quiz: QuizItem // Cuestionario individual.
    @Binding var favoriteQuizzes: Set<Int> // Vincula los favoritos.
    @State private var model = QuizzesModel() // Modelo del cuestionario.
    
    var body: some View {
        HStack { // Organiza los elementos horizontalmente.
            
            // Imagen asociada al cuestionario (si existe).
            AsyncImage(url: quiz.attachment?.url) { image in
                image.resizable().scaledToFill() // Ajusta la imagen al espacio disponible.
            } placeholder: {
                Image(systemName: "questionmark.circle") // Marcador de posición.
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .frame(width: 60, height: 60) // Tamaño de la imagen.
            .clipShape(Circle()) // Imagen recortada en forma de círculo.
            .shadow(radius: 8) // Sombra alrededor de la imagen.

            // Información del cuestionario.
            VStack(alignment: .leading) {
                
                Text(quiz.question) // Muestra la pregunta.
                    .font(.headline)
                    .lineLimit(2) // Limita a dos líneas.
                
                if let author = quiz.author { // Si el autor está disponible.
                    HStack {
                        AsyncImage(url: author.photo?.url) { image in
                            image.resizable()
                        } placeholder: {
                            Circle().fill(Color.gray) // Marcador de posición del autor.
                        }
                        .frame(width: 15, height: 15)
                        .clipShape(Circle())
                        
                        Text(author.profileName ?? author.username ?? "Unknown") // Nombre del autor.
                            .font(.caption)
                    }
                }
            }
            Spacer()
            
            // Botón para marcar o desmarcar como favorito.
            Button(action: {
                toggleFavorite(for: quiz.id) // Alterna el estado de favorito.
            }) {
                Image(systemName: favoriteQuizzes.contains(quiz.id) ? "star.fill" : "star") // Icono de estrella.
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.plain) // Estilo sin decoraciones.
        }
    }

    //-------------------------------[ToggleFavorite]----------------------------------------

    // Alterna el estado de favorito de un cuestionario.
    private func toggleFavorite(for quizId: Int) {
        let isFavourite = favoriteQuizzes.contains(quizId)
        let httpMethod = isFavourite ? "DELETE" : "PUT"
        
        guard let url = URL(string: "https://quiz.dit.upm.es/api/users/tokenOwner/favourites/\(quizId)?token=<YOUR_API_TOKEN>") else {
            print("Error: URL no válida")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Operación exitosa (HTTP 200)")
            }
            
            if isFavourite {
                favoriteQuizzes.remove(quizId) // Actualiza localmente si es favorito.
            } else {
                favoriteQuizzes.insert(quizId)
            }
            
        }.resume()
    }
}

//-------------------------------[QuizFilterOption]----------------------------------------

// Enum que define las opciones de filtro disponibles.
enum QuizFilterOption: String, CaseIterable {
    case all = "Todos"
    case correct = "Acertados"
    case notCorrect = "No acertados"
}
