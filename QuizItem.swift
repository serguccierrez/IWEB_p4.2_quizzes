//
//  QuizItem.swift
//  Quiz
//
//  Created by Santiago Pavón Gómez on 18/10/24.
//

// Importa el framework Foundation, necesario para trabajar con tipos básicos y protocolos como Codable.
import Foundation

//-------------------------------[QuizItem]----------------------------------------

struct QuizItem: Codable, Identifiable {
    // Identificador único del cuestionario.
    let id: Int
    // Texto de la pregunta asociada al cuestionario.
    let question: String
    // Información del autor del cuestionario, opcional.
    let author: Author?
    // Información del archivo adjunto (imagen o multimedia), opcional.
    let attachment: Attachment?
    // Indica si el cuestionario está marcado como favorito.
    let favourite: Bool
    
    //-------------------------------[Author]----------------------------------------

    // Define una estructura anidada `Author` que representa al autor del cuestionario.
    struct Author: Codable {
        // Identificador único del autor.
        let id: Int
        // Indica si el autor tiene privilegios de administrador.
        let isAdmin: Bool
        // Nombre de usuario del autor, opcional.
        let username: String?
        // Tipo de cuenta asociado al autor, opcional.
        let accountTypeId: Int?
        // Identificador del perfil del autor, opcional y de tipo Decimal.
        let profileId: Decimal?
        // Nombre del perfil del autor, opcional.
        let profileName: String?
        // Foto asociada al autor, opcional, representada como un objeto `Photo`.
        let photo: Photo?
        
        //-------------------------------[Photo]----------------------------------------

        // Define una estructura anidada `Photo` que representa la foto del autor.
        struct Photo: Codable {
            // Tipo MIME de la foto (por ejemplo, `image/jpeg`), opcional.
            let mime: String?
            // URL de la foto, opcional.
            let url: URL?
        }
    }
    
    //-------------------------------[Attachment]----------------------------------------

    // Define una estructura anidada `Attachment` que representa un archivo adjunto.
    struct Attachment: Codable {
        // Tipo MIME del archivo adjunto (por ejemplo, `image/png`), opcional.
        let mime: String?
        // URL donde se encuentra alojado el archivo, opcional.
        let url: URL?
    }
}
