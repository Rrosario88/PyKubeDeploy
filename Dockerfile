# Use an official Python runtime as the base image
FROM python:3.8-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Explicitly copy the requirements.txt file
COPY requirements.txt .

# Install pip
RUN python3 -m ensurepip --upgrade


# Install any necessary dependencies
 RUN pip3 install --no-cache-dir -r requirements.txt --verbose --no-use-pep517

# Make port 5000 & port 80 available to the outside world
EXPOSE 5000
EXPOSE 80

# Run app.py when the container launches
CMD ["python3", "app.py"]
