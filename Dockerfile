# Use an official Python runtime as the base image
FROM python:3.8-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Explicitly copy the requirements.txt file
COPY requirements.txt .

# Install any necessary dependencies


# Make port 5000 & port 80 available to the outside world
EXPOSE 5000
EXPOSE 80

# Run app.py when the container launches
CMD ["python", "app.py"]
