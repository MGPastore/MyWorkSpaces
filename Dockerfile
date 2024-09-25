FROM ghcr.io/coder/code-server:latest

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto
EXPOSE 8080

# Inicia el código
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password", "--password", "$PASSWORD"]
