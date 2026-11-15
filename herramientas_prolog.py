from langchain_core.tools import tool
from pyswip import Prolog

# Inicializar Prolog y cargar la base de conocimientos
prolog = Prolog()
prolog.consult("Comics.pl")

@tool
def consultar_prolog(query: str) -> str:
    """
    Ejecuta una consulta lógica en Prolog sobre la base de conocimientos de cómics.
    La entrada debe ser una consulta válida en Prolog terminada en punto.
    Ejemplo: autor(C, grant_morrison), editorial(C, dc).
    """
    try:
        query = query.strip()
        if query.endswith('.'):
            query = query[:-1]
            
        resultados = list(prolog.query(query))
        
        if not resultados:
            return "No se encontraron resultados para la consulta."
        
        return str(resultados)
    except Exception as e:
        return f"Error al ejecutar la consulta en Prolog: {str(e)}"