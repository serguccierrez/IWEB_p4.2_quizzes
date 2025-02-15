//
//  P4_IWEBApp.swift
//  P4-IWEB
//
//  Created by labditmacvm on 13/11/24.
//

// Importa el framework SwiftUI, necesario para construir la interfaz de usuario.
import SwiftUI

// Marca el punto de entrada principal de la aplicación con la anotación `@main`.
@main
struct P4_IWEBApp: App {
    // Define el contenido principal de la aplicación.
    var body: some Scene {
        // Define una ventana principal para la aplicación.
        WindowGroup {
            // Especifica la vista inicial que se mostrará al abrir la aplicación.
            Splashview()
        }
    }
}
