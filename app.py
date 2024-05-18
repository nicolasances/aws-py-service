from flask import Flask, request
from flask_cors import CORS

from smoke import test_smoke

app = Flask(__name__)
CORS(app, origins=["*"])

@app.route('/', methods=['GET'])
def smoke():
    return {"api": "test", "running": True}

@app.route('/smoke', methods=['GET'])
def testing(): 
    return test_smoke(request)

if __name__ == '__main__':
    app.run()