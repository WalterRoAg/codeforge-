# 🛠️ CodeForge — Plataforma Colaborativa con IA para Modelado UML

![Java](https://img.shields.io/badge/Java-17%20%7C%2021-orange?logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?logo=springboot)
![Angular](https://img.shields.io/badge/Angular-19.x-red?logo=angular)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)
![Ollama](https://img.shields.io/badge/Ollama-Local%20AI-black?logo=ollama)
![Gemini](https://img.shields.io/badge/Google%20Gemini-2.5%20Flash-blueviolet?logo=google)

**CodeForge** es una plataforma colaborativa en tiempo real diseñada para el análisis, diseño y arquitectura de software bajo el estándar **UML 2.5**. Integra un sistema de asistencia inteligente híbrido (Cloud y Offline) basado en **propuestas transaccionales auditables** con control de concurrencia optimista, permitiendo a equipos de desarrollo debatir, aprobar o rechazar cambios sugeridos por inteligencia artificial sin mutaciones opacas sobre el modelo activo.

---

## 🏛️ Arquitectura del Monorepo

El repositorio está organizado en tres componentes principales y módulos de infraestructura:

```
2PARCIAL_SW/
├── codeforge-backend/       # API RESTful, WebSockets e IA (Spring Boot 3 + Java)
├── codeforge-frontend/      # Cliente Web interactivo con JointJS (Angular 19 + TypeScript)
├── codeforge-movil/         # Aplicación Móvil de consulta y gestión (Flutter / Dart)
├── docker-compose.yml       # Orquestación de contenedores (DB, Ollama, Backend, Frontend)
├── codeforge_schema_ea.sql  # Esquema relacional centralizado para PostgreSQL
├── iniciar-ia-local.bat     # Lanzador automatizado para Ollama y modelo local
├── INSTRUCCIONES_IA_LOCAL.md# Documentación técnica para ejecución offline (8 GB RAM)
├── spec.md                  # Especificación de requisitos y casos de uso (EARS)
└── .env.example             # Plantilla de variables de entorno
```

---

## 🚀 Capacidades Principales

1. **Modelado UML 2.5 Colaborativo:** Diagramas de clases, interfaces, asociaciones, agregaciones, composiciones y herencia con renderizado interactivo en canvas.
2. **Asistencia de IA Multirrol (10 Roles Técnicos):** Modelador UML, Arquitecto de Software, Revisor de Código, Documentador, Especialista en Requisitos, etc.
3. **Estrategia de IA Híbrida y Resiliente:**
   - **Nube:** Google Gemini API para razonamiento complejo, análisis de imágenes (visión multimodal) y notas de voz.
   - **Local / Offline:** Motor Ollama con el modelo `qwen2.5-coder:1.5b` (~986 MB en disco, ~1.2 GB de RAM), garantizando operatividad continua en equipos de 8 GB de RAM sin internet.
4. **Propuestas Transaccionales Auditables:** La IA genera operaciones estructuradas (`CREAR_CLASE`, `AGREGAR_ATRIBUTO`, `CREAR_RELACION`) que requieren aprobación humana antes de impactar el modelo.
5. **Sincronización en Tiempo Real:** Notificaciones de chat, cambios de propuestas y eventos mediante WebSockets (STOMP).
6. **Multiplataforma:** Web moderna y cliente móvil en Flutter.

---

## 📋 Requisitos Previos

* **Java Development Kit (JDK):** Versión 17 o 21.
* **Node.js:** Versión 20+ o 22 LTS (con npm).
* **Flutter SDK:** Versión 3.x (para la app móvil).
* **Docker & Docker Compose:** (Opcional, pero recomendado para despliegue rápido).
* **Ollama:** (Para ejecutar la IA local offline). Descargable desde [ollama.com](https://ollama.com).

---

## ⚙️ Configuración de Variables de Entorno

Copia el archivo de ejemplo `.env.example` como `.env` en la raíz del proyecto:

```bash
cp .env.example .env
```

Edita el archivo `.env` según tu configuración:

```env
DB_PASSWORD=1234
GOOGLE_API_KEY=tu_api_key_de_gemini_aqui
GEMINI_MODEL=gemini-2.5-flash
```

> **Nota:** Si no dispones de una clave de Google Gemini, el sistema utilizará automáticamente el motor local **Ollama** si está instalado y en ejecución.

---

## 🐳 Despliegue con Docker Compose (Recomendado)

Para levantar todos los servicios (PostgreSQL, Ollama, Backend y Frontend Web) en un solo paso:

```bash
docker-compose up --build -d
```

* **Frontend Web:** `http://localhost` (puerto 80)
* **Backend API:** `http://localhost:8080/api`
* **Base de Datos PostgreSQL:** `localhost:5432` (Base de datos: `codeforge_central`)
* **Motor Ollama:** `http://localhost:11434`

Para detener los contenedores:
```bash
docker-compose down
```

---

## 💻 Ejecución en Modo Desarrollo Local

### 1. Base de Datos
Asegúrate de tener una instancia de PostgreSQL 15+ corriendo en el puerto 5432 con la base de datos `codeforge_central`, o levanta solo la BD con Docker:
```bash
docker-compose up -d codeforge-db
```
Si requieres inicializar las tablas manualmente, ejecuta el script `codeforge_schema_ea.sql`.

### 2. Motor de IA Local (Ollama)
Si vas a utilizar la IA offline:
1. Instala [Ollama](https://ollama.com).
2. Descarga el modelo:
   ```bash
   ollama pull qwen2.5-coder:1.5b
   ```
3. O simplemente ejecuta el archivo en Windows:
   ```cmd
   iniciar-ia-local.bat
   ```
   *(Consulta [INSTRUCCIONES_IA_LOCAL.md](INSTRUCCIONES_IA_LOCAL.md) para más detalles).*

### 3. Backend (Spring Boot)
```bash
cd codeforge-backend
./mvnw clean spring-boot:run
```
*(En Windows también puedes usar `mvnw.cmd clean spring-boot:run`).*

El backend iniciará en `http://localhost:8080`.

### 4. Frontend Web (Angular)
```bash
cd codeforge-frontend
npm install
npm start
```
El cliente web estará disponible en `http://localhost:4200`.

### 5. Aplicación Móvil (Flutter)
```bash
cd codeforge-movil
flutter pub get
flutter run
```
*Puedes configurar la URL del backend directamente desde la pantalla de inicio de sesión de la app.*

---

## 🔒 Seguridad y Buenas Prácticas

- Los archivos `.env` y credenciales privadas están ignorados en `.gitignore` para evitar fugas accidentales.
- El repositorio excluye cachés de build (`node_modules`, `target`, `.gradle`, `.dart_tool`).
- Todas las operaciones sensibles de modelo están protegidas por control de concurrencia optimista mediante hash semántico de versión.

---

## 👤 Autor

* **Walter Rodríguez Aguilera** ([@WalterRoAg](https://github.com/WalterRoAg))
* Email: [rodriguezaguilerawalter@gmail.com](mailto:rodriguezaguilerawalter@gmail.com)
