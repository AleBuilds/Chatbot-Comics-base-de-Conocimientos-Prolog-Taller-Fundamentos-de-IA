# Chatbot Cómics - Base de Conocimientos Prolog

Proyecto de Taller de Fundamentos de Inteligencia Artificial. Asistente inteligente basado en LangGraph / LangChain con LLM Gemini y motor de inferencia lógica en Prolog (`pyswip`).

---

## 📋 Requisitos Previos

1. **Python 3.10 o superior**.
2. **SWI-Prolog** instalado en el sistema:
   - **Windows:** Descargar el instalador de [SWI-Prolog](https://www.swi-prolog.org/download/stable) e instalarlo marcando la casilla **"Add swipl to the system PATH"**.
   - **Linux / Debian / Ubuntu:** `sudo apt-get install swi-prolog`
   - **macOS:** `brew install swi-prolog`

---

## 🚀 Instalación y Puesta en Marcha

### 1. Clonar el repositorio
```bash
git clone https://github.com/AleBuilds/Chatbot-Comics-base-de-Conocimientos-Prolog-Taller-Fundamentos-de-IA.git
cd Chatbot-Comics-base-de-Conocimientos-Prolog-Taller-Fundamentos-de-IA
```

### 2. Crear y activar el entorno virtual

- **Windows (PowerShell):**
  ```powershell
  python -m venv .venv
  .\.venv\Scripts\Activate.ps1
  ```
- **Linux / macOS / Git Bash:**
  ```bash
  python3 -m venv .venv
  source .venv/bin/activate
  ```

### 3. Instalar dependencias
```bash
pip install -r requirements.txt
```

### 4. Configurar variables de entorno
Crea un archivo llamado `.env` en la raíz del proyecto (puedes basarte en `.env.example`):
```env
GOOGLE_API_KEY=tu_api_key_de_gemini
```

### 5. Ejecutar la aplicación
```bash
python app.py
```
Abre tu navegador en `http://127.0.0.1:5000` para interactuar con el chatbot.
