from flask import Flask, request, Response

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    return Response('Hello!', content_type='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)