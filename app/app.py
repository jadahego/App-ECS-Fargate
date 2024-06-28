import logging
from flask import Flask, jsonify, request

# Configurar el logging
logging.basicConfig(level=logging.INFO)

app = Flask(__name__)

votes = {"option1": 0, "option2": 0}

@app.route('/')
def home():
    return "Welcome to the Voting App!"

@app.route('/vote', methods=['POST'])
def vote():
    data = request.get_json()
    option = data.get('option')
    if option in votes:
        votes[option] += 1
        return jsonify({"message": "Vote counted!"}), 200
    return jsonify({"message": "Invalid option"}), 400

@app.route('/results', methods=['GET'])
def results():
    return jsonify(votes), 200

# Ruta de salud para AWS ALB
@app.route('/health')
def health_check():
    # Puedes implementar lógica de verificación de salud aquí si es necesario
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=3000, debug=True)     
  
