# Chatbot de Comics - Base de Conocimientos en Prolog

Asistente inteligente experto en comics de superheroes (Marvel y DC) desarrollado para el Taller de Fundamentos de Inteligencia Artificial. El sistema combina un modelo de lenguaje (Google Gemini) mediante LangGraph/LangChain con un motor de inferencia logica en Prolog (`pyswip`) para consultar hechos y reglas estructuradas sobre comics.

---

## Software y herramientas requeridas (Instalacion previa)

Antes de levantar el proyecto, debes contar con las siguientes herramientas instaladas en tu equipo:

### 1. Requisitos generales obligatorios
- Git:
  - Descarga: https://git-scm.com/downloads
  - Utilizado para clonar el repositorio del proyecto.
- Clave de API de Google Gemini:
  - Registro: https://aistudio.google.com/
  - Dirigete a la seccion "Get API key", genera una clave y guardala para el archivo `.env`.

### 2. Si eliges ejecutar con Docker (Metodo Recomendado)
Solo necesitas:
- Docker Desktop:
  - Descarga: https://www.docker.com/products/docker-desktop/
  - En Windows: Durante la instalacion, asegurate de mantener activada la casilla para habilitar el backend de WSL 2 (Windows Subsystem for Linux).
  - Una vez instalado, inicia la aplicacion Docker Desktop y confirma que el motor este en estado de ejecucion ("Engine running").
  - Ventaja: No requieres instalar Python ni SWI-Prolog en tu sistema operativo, ya que el contenedor incluye todo el entorno preconfigurado de forma aislada.

### 3. Si eliges ejecutar de forma Local (Sin Docker)
Debes instalar en tu maquina local las siguientes dependencias del sistema:
- Python (version 3.10 o superior, arquitectura de 64 bits):
  - Descarga: https://www.python.org/downloads/
  - En Windows: En la primera ventana del instalador, marca obligatoriamente la casilla "Add python.exe to PATH" antes de hacer clic en instalar.
- SWI-Prolog (version estable de 64 bits):
  - Descarga: https://www.swi-prolog.org/download/stable
  - En Windows:
    1. Descarga el instalador de 64 bits (`swipl-x.x.x-x64.exe`). La arquitectura debe coincidir con la de Python (64 bits con 64 bits), de lo contrario la libreria `pyswip` emitira un error de DLL.
    2. Durante el asistente de instalacion, selecciona la opcion de agregar SWI-Prolog a la variable PATH del sistema ("Add swipl to the system PATH").
    3. Verifica que la carpeta `bin` de SWI-Prolog (usualmente `C:\Program Files\swipl\bin`) se encuentre en las Variables de Entorno del sistema.
  - En Linux (Debian / Ubuntu):
    ```bash
    sudo apt-get update
    sudo apt-get install swi-prolog
    ```
  - En macOS (con Homebrew):
    ```bash
    brew install swi-prolog
    ```

---

## Paso 1: Clonar el repositorio y configurar variables de entorno

1. Abre tu terminal o consola de comandos y clona el repositorio (o ubicate en la carpeta descargada):
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd chatbot
   ```

2. Crea tu archivo de configuracion local `.env` a partir de la plantilla `.env.example`:
   - En Windows (PowerShell):
     ```powershell
     Copy-Item .env.example .env
     ```
   - En Linux / macOS / Git Bash:
     ```bash
     cp .env.example .env
     ```

3. Abre el archivo `.env` con un editor de texto y asigna tu clave de Google Gemini:
   ```env
   GOOGLE_API_KEY=TU_CLAVE_DE_GEMINI_AQUI
   ```

---

## Paso 2: Levantar el proyecto

Elige uno de los dos metodos siguientes para poner en marcha el sistema.

### Metodo A: Ejecucion con Docker (Recomendado)

Docker crea un contenedor Linux ligero que contiene Python 3.10 y SWI-Prolog preinstalados, eliminando cualquier problema de incompatibilidad con librerias nativas en Windows o macOS.

1. Abre Docker Desktop y asegurate de que este corriendo.

2. Abre una terminal en la raiz del proyecto y construye la imagen:
   ```bash
   docker build -t chatbot-comics .
   ```

3. Ejecuta el contenedor asociando el archivo `.env` y mapeando el puerto 5000:
   ```bash
   docker run -d -p 5000:5000 --env-file .env --name chatbot-comics-app chatbot-comics
   ```

4. Abre tu navegador web e ingresa a la siguiente direccion:
   ```text
   http://localhost:5000
   ```

#### Comandos utiles para gestionar el contenedor:
- Ver registros de ejecucion (logs):
  ```bash
  docker logs -f chatbot-comics-app
  ```
- Detener el contenedor:
  ```bash
  docker stop chatbot-comics-app
  ```
- Volver a iniciar el contenedor detenido:
  ```bash
  docker start chatbot-comics-app
  ```
- Eliminar el contenedor para crearlo nuevamente:
  ```bash
  docker rm -f chatbot-comics-app
  ```

---

### Metodo B: Ejecucion local (sin Docker)

Utiliza este metodo unicamente si instalaste previamente Python y SWI-Prolog en tu sistema operativo como se indico en los requisitos previos.

1. Abre una terminal en la carpeta del proyecto y crea un entorno virtual de Python:
   ```bash
   python -m venv .venv
   ```

2. Activa el entorno virtual:
   - En Windows (PowerShell):
     ```powershell
     .venv\Scripts\Activate.ps1
     ```
     *(Si PowerShell bloquea la ejecucion de scripts, ejecuta una sola vez: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`)*
   - En Windows (cmd):
     ```cmd
     .venv\Scripts\activate.bat
     ```
   - En Linux / macOS:
     ```bash
     source .venv/bin/activate
     ```

3. Instala las dependencias necesarias de Python:
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

4. Asegurate de que el archivo `.env` este creado en la raiz con tu `GOOGLE_API_KEY`.

5. Inicia el servidor Flask:
   ```bash
   python app.py
   ```

6. Abre tu navegador web e ingresa a:
   ```text
   http://localhost:5000
   ```

---

## Estructura del proyecto

- `app.py`: Servidor web Flask que expone la interfaz grafica y el endpoint `/chat`.
- `agente.py`: Agente de LangGraph con el modelo Gemini, instrucciones del sistema y manejo de memoria/herramientas.
- `herramientas_prolog.py`: Herramienta de integracion con `pyswip` para ejecutar las consultas hacia Prolog.
- `Comics.pl`: Base de conocimientos en Prolog con hechos y reglas sobre editoriales, autores, anos, personajes y arcos argumentales.
- `templates/index.html`: Interfaz web interactiva del chatbot.
- `Dockerfile`: Especificacion de la imagen Docker basada en `python:3.10-slim` con instalacion de `swi-prolog`.
- `requirements.txt`: Dependencias de Python del proyecto.
- `.env.example`: Plantilla de variables de entorno requeridas.

---

## Ejemplos de uso en el chat

Una vez dentro de la aplicacion en el navegador, puedes consultar datos registrados en la base de conocimientos:
- "¿Que comics de DC fueron escritos por Grant Morrison?"
- "¿En que comic aparece Batman y quien es su villano principal?"
- "Muestrame comics publicados a partir del ano 2000 que pertenezcan a Marvel."
- "¿Cual es la tematica y la escala de amenaza en Kingdom Come?"
