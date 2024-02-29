# Gunakan `python:3.11.4` sebagai base image
FROM python:3.11.4

# Set the working directory in the container
WORKDIR /
# Copy the current directory contents into the container at /app
COPY . /

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Command to run the application within the container
CMD ["python", "etl.py"]