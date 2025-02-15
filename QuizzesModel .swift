//
//  QuizzesModel.swift
//  Quiz
//
//  Created by Santiago Pavón Gómez on 18/10/24.
//

import Foundation

//-------------------------------[QuizzesModelError]----------------------------------------

/// Enum que define los posibles errores en el modelo de cuestionarios (`QuizzesModel`).
enum QuizzesModelError: LocalizedError {
    case internalError(msg: String) // Error interno con un mensaje descriptivo.
    case corruptedDataError // Error cuando los datos recibidos están corruptos o no válidos.
    case unknownError // Error genérico para casos desconocidos.

    // Proporciona una descripción legible para cada tipo de error.
    var errorDescription: String? {
        switch self {
        case .internalError(let msg):
            return "Error interno: \(msg)" // Mensaje personalizado para errores internos.
        case .corruptedDataError:
            return "Recibidos datos corruptos" // Mensaje para datos corruptos.
        case .unknownError:
            return "Ha ocurrido un error desconocido" // Mensaje genérico para errores desconocidos.
       }
    }
}

//-------------------------------[QuizzesModel]----------------------------------------

// Clase principal que maneja los datos y operaciones relacionadas con los cuestionarios.
@Observable class QuizzesModel {
    
    // Array que contiene los cuestionarios descargados.
    private(set) var quizzes = [QuizItem]() // `private(set)` permite que esta propiedad sea leída desde fuera, pero modificada solo dentro de la clase.
    
    //-------------------------------[GetQuizzes]----------------------------------------

    /// Descarga los cuestionarios desde la API.
    func getQuizzes() throws {
        
        // Define la URL de la API para obtener 10 cuestionarios aleatorios.
        guard let apiURL = URL(string: "https://quiz.dit.upm.es/api/quizzes/random10?token=<YOUR_API_TOKEN>") else {
            throw QuizzesModelError.internalError(msg: "URL inválida") // Lanza un error si la URL es inválida.
        }
        
        // Realiza una solicitud HTTP a la URL usando `URLSession`.
        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            
            // Maneja errores de red, si ocurren.
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                return
            }
            
            // Verifica que se hayan recibido datos en la respuesta.
            guard let data = data else {
                print("No hay datos en la respuesta") // Imprime un mensaje si no hay datos.
                return
            }
            
            // Convierte los datos recibidos a una cadena JSON para depuración.
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON recibido: \n(\(jsonString))")
            }
            
            do {
                // Crea un decodificador JSON.
                let decoder = JSONDecoder()
                
                // Decodifica los datos JSON en un array de objetos `QuizItem`.
                let downloadedQuizzes = try decoder.decode([QuizItem].self, from: data)
                
                // Actualiza la propiedad `quizzes` con los datos descargados.
                self.quizzes = downloadedQuizzes
                print("Quizzes cargados correctamente")
            } catch {
                // Maneja errores de decodificación.
                print("Error inesperado: \(error.localizedDescription)")
            }
        }.resume() // Inicia la tarea de descarga.
    }
}
