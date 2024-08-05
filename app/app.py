"""
This module contains the Flask application code for the health check endpoint.
"""
import os
from flask import Flask
import psycopg2
from psycopg2 import OperationalError

app = Flask(__name__)

@app.route('/live')
def live():
    """
    Health check endpoint that verifies database connectivity.
    
    Returns:
        str: A success message if the database connection is successful.
        tuple: A maintenance message and status code if the database connection fails.
    """
    try:
        conn = psycopg2.connect(os.getenv('DATABASE_URL'))
        conn.close()
        return 'Well done', 200
    except OperationalError:
        return 'Maintenance', 503

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
