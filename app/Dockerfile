# Use an official Python runtime as a parent image
FROM python:3.12-slim

#Define build argument
ARG DATABASE_URL

# Define environment variable
ENV DATABASE_URL=$(DATABASE_URL)

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# You need to create a requirements.txt file with Flask and psycopg2 listed
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]