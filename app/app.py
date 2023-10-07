from flask import Flask
from redis import Redis
import os

app = Flask(__name__)
redis_host = os.getenv('REDIS_HOST', 'redis')
print(f"Connecting to Redis host: {redis_host}")
cache = Redis(host=redis_host, port=6379, db=0)

@app.route('/')
def hello():
    count = cache.incr('hits')
    return 'Welcome to my first project: This amazing page has been viewed {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
