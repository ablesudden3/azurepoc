"""
This module contains test cases for the Flask application.
"""
import pytest
import psycopg2
from app import app

@pytest.fixture
def client():
    """
    Fixture to create a test client for the Flask application.
    """
    app.config['TESTING'] = True
    with app.test_client() as test_client:
        yield test_client

def test_live_success(client, monkeypatch):
    """
    Test case for a successful database connection.
    """
    def mock_connect(*args, **kwargs):
        """
        Mock function to simulate a successful database connection.
        """
        class MockConnection:
            """
            Mock connection class.
            """
            def close(self):
                """
                Mock close method.
                """
                # No operation (no-op)

            def execute(self):
                """
                Mock execute method.
                """
                # No operation (no-op)

        return MockConnection()

    monkeypatch.setattr('psycopg2.connect', mock_connect)
    response = client.get('/live')
    assert response.status_code == 200
    assert response.data == b'Well done'

def test_live_failure(client, monkeypatch):
    """
    Test case for a failed database connection.
    """
    def mock_connect(*args, **kwargs):
        """
        Mock function to simulate a failed database connection.
        """
        raise psycopg2.OperationalError

    monkeypatch.setattr('psycopg2.connect', mock_connect)
    response = client.get('/live')
    assert response.status_code == 503
    assert response.data == b'Maintenance'
