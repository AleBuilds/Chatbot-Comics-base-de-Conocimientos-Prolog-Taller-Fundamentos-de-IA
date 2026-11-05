from langchain_openai import ChatOpenAI
from langchain.agents import create_openai_functions_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate

# IMPORTACIÓN CLAVE: Traemos la herramienta desde el otro archivo
from herramientas_prolog import consultar_prolog

# 1. Configurar el LLM
llm = ChatOpenAI(model="gpt-4o", temperature=0)

# 2. Definir los prompts del sistema
prompt = ChatPromptTemplate.from_messages([
    ("system", "Eres un asistente experto en lógica. Tienes acceso a una base de conocimientos en Prolog. "
               "Traduce las preguntas del usuario a consultas válidas de Prolog usando la herramienta."),
    ("placeholder", "{chat_history}"),
    ("human", "{input}"),
    ("placeholder", "{agent_scratchpad}"),
])

# 3. Construir el Agente cargando la herramienta importada
tools = [consultar_prolog]
agent = create_openai_functions_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

# 4. Ejecución
if __name__ == "__main__":
    respuesta = agent_executor.invoke({"input": "¿Quiénes son los nietos de juan?"})
    print(respuesta["output"])
