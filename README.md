# 🎬 eMovie

Aplicación Flutter que consume contenido de películas desde la API pública de [The Movie Database (TMDb)](https://api.themoviedb.org). Permite explorar tendencias, próximos estrenos y recomendaciones personalizadas, con una arquitectura modular, escalable y preparada para funcionar sin conexión.

📱 Descarga la APK en tu movil, para hacer las respectivas pruebas y funcionalidades desarrollados: https://drive.google.com/file/d/1w68GxyRUyrcNxEEBU09OFTmt6bI2KPgn/view?pli=1

---

## 🚀 Funcionalidades principales

- 🔌 **Consumo de API REST** de TMDb:
  - [`/3/movie/upcoming`](https://api.themoviedb.org/3/movie/upcoming): Próximos estrenos
  - [`/3/trending/movie/week`](https://api.themoviedb.org/3/trending/movie/week): Películas en tendencia semanal
  - [`/3/movie/550/recommendations`](https://api.themoviedb.org/3/movie/550/recommendations): Recomendaciones basadas en una película
  - [`/3/movie/680`](https://api.themoviedb.org/3/movie/680): Detalles de película
  - [`/3/movie/680/videos`](https://api.themoviedb.org/3/movie/680/videos): Trailers y videos relacionados

- 📦 **Cache offline**: La app puede mostrar contenido previamente cargado si no hay conexión a internet.

- 🎞️ **Transiciones y animaciones**: Animaciones suaves para carga de imágenes (`FadeInImage`) y navegación entre pantallas.

- 🧱 **Modularidad**: Separación clara por features, componentes y capas (`data`, `domain`, `presentation`).

- 📈 **Escalabilidad y mantenibilidad**: Estructura de carpetas y arquitectura pensadas para crecer sin comprometer claridad ni rendimiento.

- ✅ **Buenas prácticas**:
  - Nombres descriptivos y consistentes
  - Manejo robusto de errores y estados
  - Uso de `Provider` para gestión de estado reactiva
  - Separación de constantes, estilos y widgets reutilizables

- 🧪 **Pruebas unitarias y de widgets**:
  - Prueba de renderizado de `HomeScreen`
  - Prueba unitaria de `ConnectivityHelper` con `mocktail`

---

## 📚 Recursos útiles para Flutter

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter documentation](https://docs.flutter.dev/)

---

## ✅ Criterios evaluados

| Criterio                          | Estado |
|----------------------------------|--------|
| Legibilidad del código           | ✅     |
| Escalabilidad de la arquitectura| ✅     |
| Modularidad y desacoplamiento    | ✅     |
| Correcto uso de Flutter          | ✅     |
| Buen manejo de estado            | ✅     |
| UI limpia y funcional            | ✅     |
| Manejo de errores y estados      | ✅     |
| Pruebas unitarias o de widget    | ✅     |

---

Desarrollado con ❤️ en Flutter.
