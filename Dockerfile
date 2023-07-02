# Use an official Python runtime as the base image
FROM python:3.8

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the outside world
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]
