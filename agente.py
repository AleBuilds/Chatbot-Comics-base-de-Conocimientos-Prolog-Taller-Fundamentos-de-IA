import os
from dotenv import load_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
from langgraph.prebuilt import create_react_agent
from herramientas_prolog import consultar_prolog

# Cargar variables de entorno desde el archivo .env si existe
load_dotenv()

# 1. Configurar el LLM
llm = ChatGoogleGenerativeAI(
    model="gemini-flash-lite-latest",
    temperature=0,
    max_retries=5
)

# 2. Instrucciones del sistema
instrucciones = (
    "Eres un asistente experto en cómics de superhéroes. Tienes acceso a una base de conocimientos en Prolog. "
    "Traduce las preguntas del usuario a consultas lógicas de Prolog usando la herramienta 'consultar_prolog'. "
    "Predicados disponibles: comic(X), editorial(X, E), anio_publicacion(X, A), autor(X, A), "
    "universo_principal(X, U), formato_serie(X, F) y comic_valido(X)."
)

# 3. Construir el Agente con LangGraph
tools = [consultar_prolog]
agente_langgraph = create_react_agent(llm, tools=tools)

# 4. Envoltorio para mantener compatibilidad con app.py
class AgentExecutorWrapper:
    def invoke(self, inputs):
        mensaje_usuario = inputs["input"]
        mensajes = [
            ("system", instrucciones),
            ("user", mensaje_usuario)
        ]
        resultado = agente_langgraph.invoke({"messages": mensajes})
        
        # Extraer el contenido del último mensaje
        ultimo_mensaje = resultado["messages"][-1]
        contenido = ultimo_mensaje.content
        
        # Si Gemini devuelve una lista de bloques de texto, extraer solo los textos
        if isinstance(contenido, list):
            texto_final = []
            for bloque in contenido:
                if isinstance(bloque, dict) and "text" in bloque:
                    texto_final.append(bloque["text"])
                elif isinstance(bloque, str):
                    texto_final.append(bloque)
            contenido = "\n".join(texto_final)
        elif not isinstance(contenido, str):
            contenido = str(contenido)
            
        return {"output": contenido}

agent_executor = AgentExecutorWrapper()

# 5. Prueba por consola
if __name__ == "__main__":
    respuesta = agent_executor.invoke({"input": "¿Qué cómics escritos por grant_morrison pertenecen a DC?"})
    print(respuesta["output"])