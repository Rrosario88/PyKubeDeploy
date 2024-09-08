import os
import logging
from flask import Flask, jsonify, request
from redis import Redis
from werkzeug.exceptions import InternalServerError, NotFound

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Redis configuration
redis_host = os.getenv('REDIS_HOST', 'redis')
redis_port = int(os.getenv('REDIS_PORT', 6379))
logger.info(f"Connecting to Redis host: {redis_host}:{redis_port}")
cache = Redis(host=redis_host, port=redis_port, db=0)

@app.route('/')
def hello():
    try:
        count = cache.incr('hits')
        logger.info(f"Homepage visited. Total visits: {count}")
        return jsonify({
            "message": "Welcome to PyKubeDeploy",
            "visits": count
        }), 200
    except Exception as e:
        logger.error(f"Error accessing Redis: {str(e)}")
        raise InternalServerError("Could not process request due to a server error")

@app.route('/api/data', methods=['GET', 'POST'])
def handle_data():
    if request.method == 'POST':
        data = request.json
        key = data.get('key')
        value = data.get('value')
        if key and value:
            cache.set(key, value)
            logger.info(f"Data stored: {key}: {value}")
            return jsonify({"message": "Data stored successfully"}), 201
        else:
            logger.warning("Invalid data received")
            return jsonify({"error": "Invalid data"}), 400
    else:
        keys = cache.keys('*')
        data = {key.decode('utf-8'): cache.get(key).decode('utf-8') for key in keys if key != b'hits'}
        logger.info("Data retrieved successfully")
        return jsonify(data), 200

@app.route('/health')
def health_check():
    try:
        cache.ping()
        logger.info("Health check passed")
        return jsonify({"status": "healthy"}), 200
    except Exception as e:
        logger.error(f"Health check failed: {str(e)}")
        return jsonify({"status": "unhealthy"}), 500

@app.errorhandler(404)
def not_found(error):
    logger.warning(f"404 error: {request.url}")
    return jsonify({"error": "Not found"}), 404

@app.errorhandler(500)
def server_error(error):
    logger.error(f"500 error: {str(error)}")
    return jsonify({"error": "Internal server error"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0")
