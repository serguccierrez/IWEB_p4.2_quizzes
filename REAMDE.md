# 🧠 IWEB_p4.2_quizzes

> **ES**: Proyecto desarrollado en la asignatura de **Ingeniería Web** en 4º curso de **GITST** (Grado en Ingeniería de Tecnologías y Servicios de Telecomunicación) en la **ETSIT**.  
> **EN**: Project developed for the **Web Engineering** course in the 4th year of **GITST** (Degree in Engineering of Telecommunication Technologies and Services) at **ETSIT**.

---

## 📌 Descripción | Description

🟢 **ES:**  
_IWEB_p4.2_quizzes_ es una aplicación para **iOS** que permite a los usuarios participar en **quizzes interactivos**. La aplicación obtiene los datos de los quizzes desde una **API remota** en lugar de cargar un fichero JSON local, como se hacía en **IWEB_p4.1_quizzes**.  

🔵 **EN:**  
_IWEB_p4.2_quizzes_ is an **iOS application** that allows users to participate in **interactive quizzes**. Instead of loading data from a **local JSON file** (as in **IWEB_p4.1_quizzes**), this version **fetches quiz data from a remote API**.

---

## 🌐 Diferencia con IWEB_p4.1_quizzes | Difference from IWEB_p4.1_quizzes
🔹 **ES**:
A diferencia de la versión anterior (**IWEB_p4.1_quizzes**), en esta aplicación los datos de los quizzes **no se cargan desde un fichero JSON local**, sino que se descargan dinámicamente desde una **API remota** mediante `fetch`.

🔹 **EN**:
Unlike the previous version (**IWEB_p4.1_quizzes**), this application **does not load quiz data from a local JSON file**, but instead fetches it dynamically from a **remote API**.

---

## 🚀 Características | Features

✅ **ES:**  
✔️ Carga dinámica de quizzes desde una API remota.  
✔️ Interfaz intuitiva y optimizada para iOS.  
✔️ Posibilidad de responder preguntas y ver resultados en tiempo real.  
✔️ Implementación en **SwiftUI** para una experiencia fluida.  

✅ **EN:**  
✔️ Dynamic loading of quizzes from a remote API.  
✔️ Intuitive and optimized UI for iOS.  
✔️ Answer questions and view results in real-time.  
✔️ Built with **SwiftUI** for a smooth experience.  

---
## 🛠️ Tecnologías | Technologies Used

- 🍏 **Swift** → Lenguaje principal de desarrollo.
- 📱 **SwiftUI** → Framework para la interfaz de usuario en iOS.
- 🌐 **Fetch API** → Obtención de datos desde una API remota.
- 🔐 **Autenticación con token** → Acceso seguro a los datos.
- 🎨 **Assets.xcassets** → Almacén de imágenes y recursos gráficos.

---

## 📦 Instalación | Installation

🟢 **ES:**  
Sigue estos pasos para instalar y ejecutar el proyecto:

```bash
git clone https://github.com/serguccierrez/IWEB_p4.2_quizzes.git
cd IWEB_p4.2_quizzes
open P4_IWEBApp.xcodeproj
```

Luego, **añade tu token** en los archivos mencionados, selecciona un simulador o dispositivo físico en **Xcode** y presiona ▶️ **Run**.


🔵 **EN:**  
Follow these steps to install and run the project:
```bash
git clone https://github.com/serguccierrez/IWEB_p4.2_quizzes.git
cd IWEB_p4.2_quizzes
open P4_IWEBApp.xcodeproj
```

Then, **add your token** in the mentioned files, select a simulator or physical device in **Xcode**, and press ▶️ **Run**.

---

## 🔑 Configuración del Token | Token Configuration

🔹 **ES:** Para acceder a los quizzes, es necesario generar un **token personal** en la web [quiz.dit.upm.es](https://quiz.dit.upm.es/).  
🔹 **EN:** To access the quizzes, you need to generate a **personal token** from [quiz.dit.upm.es](https://quiz.dit.upm.es/).  

🟢 **ES:**  
Una vez generado, el token debe ser añadido manualmente en los siguientes archivos:
- 📂 `QuizListViewswift.swift`
- 📂 `QuizPlayView.swift`
- 📂 `QuizzesModel.swift`

Busca las líneas donde se define el **token** y reemplaza `"<YOUR_API_TOKEN>"` con el valor generado en la web. 

⚠ **IMPORTANTE**: Sin este token, la aplicación no podrá obtener los quizzes correctamente.

🔵 **EN:**  
Once generated, the token must be manually added to the following files:

- 📂 QuizListViewswift.swift
- 📂 QuizPlayView.swift
- 📂 QuizzesModel.swift

Locate the lines where the token is defined and replace `"<YOUR_API_TOKEN>"` with the value generated on the website.

⚠ **IMPORTANT**: Without this token, the application will not be able to retrieve the quizzes correctly.

---

## 📂 Estructura del Proyecto | Project Structure

```
IWEB_p4.2_quizzes/
├── Assets.xcassets/  # Recursos gráficos y multimedia
├── HomeScreenView.swift  # Pantalla de inicio
├── QuizItem.swift  # Modelo de un quiz individual
├── QuizListViewswift.swift  # Vista de la lista de quizzes
├── QuizPlayView.swift  # Vista donde se juega el quiz
├── QuizzesModel.swift  # Lógica de datos de los quizzes
├── SettingsView.swift  # Pantalla de ajustes
├── Splashview.swift  # Pantalla de carga inicial
├── P4_IWEBApp.swift  # Punto de entrada de la app
├── README.md  # Documentación
```

---

## 📬 Contacto | Contact

📩 **serguccierrez** → [GitHub Profile](https://github.com/serguccierrez)  
Si tienes preguntas o sugerencias, crea un **issue** en este repositorio.  

If you have any questions or suggestions, feel free to open an **issue** in this repository.  

---

💡 _Made with ❤️ by **Serguccierrez**._