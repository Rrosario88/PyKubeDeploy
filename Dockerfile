# Use an official Python runtime as the base image
FROM python:3.8-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Explicitly copy the requirements.txt file
COPY requirements.txt .

# Install any necessary dependencies
 RUN pip3 install --no-cache-dir -r requirements.txt --verbose --no-use-pep517


# RUN pip3 install --no-cache-dir --upgrade pip && \
  #  pip3 install --no-cache-dir blinker==1.6.2 && \
   # pip3 install --no-cache-dir build==0.10.0 && \
   # pip3 install --no-cache-dir click==8.1.3 && \
   # pip3 install --no-cache-dir flash==1.0.3 && \
   # pip3 install --no-cache-dir Flask==2.3.2 && \
   # pip3 install --no-cache-dir itsdangerous==2.1.2 && \
  #  pip3 install --no-cache-dir Jinja2==3.1.2 && \
  #  pip3 install --no-cache-dir MarkupSafe==2.1.3 && \
   # pip3 install --no-cache-dir packaging==23.1 && \
   # pip3 install --no-cache-dir pip-tools==6.14.0 && \
   # pip3 install --no-cache-dir pyproject_hooks==1.0.0 && \
   # pip3 install --no-cache-dir redis==4.6.0 && \
   # pip3 install --no-cache-dir Werkzeug==2.3.6




# Make port 5000 & port 80 available to the outside world
EXPOSE 5000
EXPOSE 80

# Run app.py when the container launches
CMD ["python", "app.py"]
