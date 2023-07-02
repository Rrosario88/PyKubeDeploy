from flask import Flask
from redis import Redis
import os

app = Flask(__name__)
print(f"Connecting to Redis host: {os.getenv('REDIS_HOST', 'localhost')}")
cache = Redis(host=os.getenv('REDIS_HOST', 'localhost'), port=6379, db=0)


@app.route('/')
def hello():
    count = cache.incr('hits')
    return 'Hello World! This amazing page has been viewed {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)