FROM coder/code-server:latest

# Configure the working directory
WORKDIR /home/coder/project

# Expose the port
EXPOSE 8080

# Start the code-server
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password", "--password", "your_password"]
