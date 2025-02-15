import SwiftUI

//-------------------------------[QuizzPlayView]----------------------------------------

// Vista principal para jugar un cuestionario específico.
struct QuizzPlayView: View {
    let quiz: QuizItem // Cuestionario que se está jugando.
    @State var userAnswer: String = "" // Estado para almacenar la respuesta ingresada por el usuario.
    @Binding var correctAnswers: Set<Int> // Conjunto que contiene los IDs de los cuestionarios respondidos correctamente.
    @State private var showAlert = false // Estado que controla si se muestra la alerta de resultado.
    @State private var isCorrect = false // Indica si la respuesta ingresada es correcta.
    @State private var imageScale = 1.0 // Escala actual de la imagen.
    @Environment(\.verticalSizeClass) private var verticalSizeClass // Detecta la orientación de la pantalla (horizontal o vertical).
    @Binding var counter: Int // Contador para el récord de respuestas correctas.

    // Vista para orientación horizontal.
    private var horizontalView: some View {
        HStack {
            VStack {
                // Imagen adjunta al cuestionario.
                AsyncImage(url: quiz.attachment?.url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    // Marcador de posición mientras se carga la imagen.
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12)) // Bordes redondeados.
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3) // Sombra.
                .scaleEffect(imageScale) // Escala de la imagen.
                .animation(.spring(response: 0.5, dampingFraction: 0.5), value: imageScale) // Animación de escala.
                .gesture(
                    TapGesture(count: 2) // Doble toque para obtener la respuesta correcta.
                        .onEnded {
                            correcta(for: quiz.id) // Llama a la función para obtener la respuesta correcta.
                            imageScale = 1.3
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                imageScale = 1.0
                            }
                        }
                )
            }
            
            Spacer() // Espaciado flexible.

            VStack {
                // Pregunta del cuestionario.
                Text(quiz.question)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)

                // Campo de texto para ingresar la respuesta.
                TextField("Enter your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                VStack {
                    HStack {
                        // Botón para verificar la respuesta.
                        Button("Comprobar") {
                            checkAnswer(for: quiz.id, userAnswer: userAnswer)
                        }
                        .buttonStyle(.borderedProminent)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(isCorrect ? "¡Correcto!" : "¡Fallaste!"),
                                message: Text(isCorrect ? "¡Se nota que has estudiado!" : "Hay que espabilar chaval"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        // Botón para limpiar el campo de respuesta.
                        Button("Limpiar") {
                            userAnswer = ""
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    // Botón para obtener ayuda (la respuesta correcta).
                    Button("Ayudame porfa") {
                        correcta(for: quiz.id)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
    }

    // Vista para orientación vertical.
    private var verticalView: some View {
        VStack {
            AsyncImage(url: quiz.attachment?.url) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3)
            .scaleEffect(imageScale)
            .animation(.spring(response: 0.5, dampingFraction: 0.5), value: imageScale)
            .gesture(
                TapGesture(count: 2)
                    .onEnded {
                        correcta(for: quiz.id)
                        imageScale = 1.3
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            imageScale = 1.0
                        }
                    }
            )

            Text(quiz.question)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            TextField("Introduce una respuesta", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .padding(.bottom, 20)

            VStack {
                HStack {
                    Button("Comprobar") {
                        checkAnswer(for: quiz.id, userAnswer: userAnswer)
                    }
                    .buttonStyle(.borderedProminent)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(isCorrect ? "¡Correcto!" : "¡Fallaste!"),
                            message: Text(isCorrect ? "¡Se nota que has estudiado!" : "Hay que espabilar chaval"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    Button("Limpiar") {
                        userAnswer = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                Button("Ayudame porfa") {
                    correcta(for: quiz.id)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    var body: some View {
        // Comprobación de la orientación de la pantalla.
        if verticalSizeClass == .compact {
            horizontalView
        } else {
            verticalView
        }
    }

    //-------------------------------[CheckAnswer]----------------------------------------

    // Verifica si la respuesta ingresada es correcta.
    private func checkAnswer(for quizId: Int, userAnswer: String) {
        guard let userAnswer = userAnswer.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            return
        }

        guard let url = URL(string: "https://quiz.dit.upm.es/api/quizzes/\(quizId)/check?answer=\(userAnswer)&token=6a8fecdb299133b2a398") else {
            print("Error: URL no válida")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No hay datos en la respuesta")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON recibido: \n(\(jsonString))")
            }

            do {
                let decoder = JSONDecoder()
                let downloadedAnswer = try decoder.decode(CheckQuizResponse.self, from: data)
                print("Respuesta cargada correctamente")
                
                DispatchQueue.main.async {
                    isCorrect = downloadedAnswer.result
                    if isCorrect {
                        if !correctAnswers.contains(quizId) {
                            counter += 1
                            UserDefaults.standard.set(counter, forKey: "counterKey")
                        }
                        correctAnswers.insert(quizId)
                    }
                    showAlert = true
                }
            } catch {
                print("Error al decodificar la respuesta: \(error.localizedDescription)")
            }
        }.resume()
    }

    //-------------------------------[Correcta]----------------------------------------

    // Obtiene la respuesta correcta para el cuestionario.
    private func correcta(for quizId: Int) {
        guard let url = URL(string: "https://quiz.dit.upm.es/api/quizzes/\(quizId)/answer?token=6a8fecdb299133b2a398") else {
            print("Error: URL no válida")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No hay datos en la respuesta")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON recibido: \n(\(jsonString))")
            }

            do {
                let decoder = JSONDecoder()
                let downloadedAnswer = try decoder.decode(respuestacorrecta.self, from: data)
                print("Respuesta cargada correctamente")
                
                DispatchQueue.main.async {
                    userAnswer = downloadedAnswer.answer
                }
            } catch {
                print("Error al decodificar la respuesta: \(error.localizedDescription)")
            }
        }.resume()
    }
}

//-------------------------------[CheckQuizResponse]----------------------------------------

// Estructura para decodificar la respuesta de verificación.
struct CheckQuizResponse: Codable {
    let quizId: Int
    let answer: String
    let result: Bool
}

//-------------------------------[Respuestacorrecta]----------------------------------------

// Estructura para decodificar la respuesta correcta.
struct respuestacorrecta: Codable {
    let quizId: Int
    let answer: String
}
