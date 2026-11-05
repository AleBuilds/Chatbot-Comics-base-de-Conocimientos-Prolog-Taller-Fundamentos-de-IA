from flask import Flask, render_template, request, jsonify
from agente import agent_executor

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/chat", methods=["POST"])
def chat():
    user_input = request.json.get("mensaje")
    if not user_input:
        return jsonify({"respuesta": "Por favor, escribe un mensaje."})
        
    try:
        respuesta = agent_executor.invoke({"input": user_input})
        return jsonify({"respuesta": respuesta["output"]})
    except Exception as e:
        return jsonify({"respuesta": f"Error del servidor: {str(e)}"})

if __name__ == "__main__":
    app.run(debug=True)