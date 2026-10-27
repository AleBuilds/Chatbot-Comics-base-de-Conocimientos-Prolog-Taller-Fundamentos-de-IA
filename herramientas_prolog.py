from pyswip import Prolog
from langchain.agents import tool

# Inicializamos y cargamos el archivo Prolog una sola vez al importar el módulo
prolog = Prolog()
prolog.consult("Comics.pl")

@tool
def consultar_prolog(query_string: str) -> str:
    """
    Ejecuta una consulta lógica en la base de conocimientos de Prolog.
    Ingresa strings en formato Prolog válido, por ejemplo: 'abuelo(juan, X).'
    """
    query = query_string.strip().rstrip('.')
    
    try:
        resultados = list(prolog.query(query))
        if not resultados:
            return "Resultado: Falso o no se encontraron soluciones."
        return f"Resultado: Verdadero. Soluciones encontradas: {str(resultados)}"
    except Exception as e:
        return f"Error de sintaxis en la consulta: {str(e)}"
