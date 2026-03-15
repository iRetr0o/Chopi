# Chopi 🛒
## Idioma
[English](README.md) | [Español](README.es.md)

## Descripción
Chopi es una aplicación simple para iOS diseñada para gestionar listas de compras.
Permite a los usuarios crear listas, agregar productos y llevar un seguimiento de los artículos comprados.

Este proyecto fue desarrollado como parte de un proceso personal de aprendizaje para practicar desarrollo moderno en iOS utilizando SwiftUI y la arquitectura MVVM.

---

## ✨ Funcionalidades

* Crear listas de compras
* Editar y eliminar listas
* Agregar artículos a una lista
* Marcar artículos como comprados
* Actualizar el estado de los artículos
* Almacenamiento local persistente
* Interfaz limpia y responsiva

--- 

## 🧱 Arquitectura

La aplicación sigue el patrón de arquitectura **MVVM (Model–View–ViewModel)** para asegurar una separación clara de responsabilidades y facilitar las pruebas.

```
View
 ↓
ViewModel
 ↓
Service
 ↓
Persistence Layer
```

**Responsabilidades**

* **Views** → Interfaz de usuario construida con SwiftUI
* **ViewModels** → Lógica de presentación y manejo del estado
* **Services** → Acceso a datos y persistencia
* **Models** → Entidades del dominio

---

## 🛠 Tecnologías utilizadas

* Swift
* SwiftUI
* Arquitectura MVVM
* Concurrencia con Async/Await
* XCTest para pruebas unitarias

---

## 🧪 Pruebas

El proyecto incluye pruebas unitarias para la lógica principal de la aplicación:

* ViewModels
* Servicios de datos
* Lógica de negocio

Las vistas de SwiftUI se validan mediante pruebas de interfaz de usuario.

---

## 📸 Capturas de pantalla

| Inicio     | Detalle de Lista | Artículos |
| ---------- | ---------------- | --------- |
| ![Home](https://i.imgur.com/ARJNs30.png) | ![List Detail](https://i.imgur.com/Q3TJZNm.png)  | ![Items](https://i.imgur.com/6vwWNZx.png) |

---

## 🚀 Cómo empezar

### Clonar el repositorio

```
git clone https://github.com/iretr0o/chopi.git
```

### Abrir el proyecto

Abre el archivo `.xcodeproj` en Xcode.

### Ejecutar la aplicación

Selecciona un simulador o dispositivo y ejecuta el proyecto.

---

## 📦 Requisitos

* Xcode 15+
* iOS 17+
* Swift 5+

---

## 🔮 Mejoras futuras

Algunas posibles mejoras en el futuro incluyen:

* Soporte para más idiomas (por ejemplo, localización al inglés)
* Mejoras en la interfaz y experiencia de usuario
* Optimizaciones de rendimiento

---

## 📄 Licencia

Este proyecto está licenciado bajo la licencia MIT.
