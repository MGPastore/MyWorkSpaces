# Usa la imagen base de Ubuntu 20.04
FROM ubuntu:20.04

# Establece el idioma y la localización
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Agrega el repositorio de code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto para code-server
EXPOSE 8080

# Inicia code-server
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
