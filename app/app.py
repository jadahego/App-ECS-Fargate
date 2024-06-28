import logging
from flask import Flask

app = Flask(__name__)

# Configurar el logging
logging.basicConfig(level=logging.INFO)

@app.route('/')
def home():
    app.logger.info('Home endpoint was reached')
    return "Welcome to the Voting App!"

@app.route('/vote', methods=['POST'])
def vote():
    app.logger.info('Vote endpoint was reached')
    # Tu lógica aquí
    return "Vote counted!"

@app.route('/results', methods=['GET'])
def results():
    app.logger.info('Results endpoint was reached')
    # Tu lógica aquí
    return "Results displayed!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

