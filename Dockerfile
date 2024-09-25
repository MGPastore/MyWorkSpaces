FROM ubuntu:20.04

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    build-essential \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && rm -rf /var/lib/apt/lists/*

# Agrega el repositorio de code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto
EXPOSE 8080

# Inicia el código
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "none"]
