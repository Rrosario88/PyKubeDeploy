from flask import Flask
import redis

app = Flask(__name__)
cache = redis.Redis(host='localhost', port=6379, db=0)

@app.route('/')
def hello():
    count = cache.incr('hits')
    return 'Hello World! This amazing page has been viewed {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)