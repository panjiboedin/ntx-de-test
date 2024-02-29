# Gunakan `python:3.11.4` sebagai base image
FROM python:3.11.4

# Set the working directory in the container
WORKDIR /
# Copy the current directory contents into the container at /app
COPY . /

# Copy the requirements file into the container
COPY requirements.txt .

# Install any dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 6000 to the outside world
EXPOSE 6000

# Command to run the FastAPI application within the container
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "6000"]