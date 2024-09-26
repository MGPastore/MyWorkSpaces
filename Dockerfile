FROM node:20

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    libkrb5-dev \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Instala code-server globalmente con permisos
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Crea un directorio de trabajo para code-server
WORKDIR /home/coder/project
