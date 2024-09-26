FROM node:20-alpine

# Instala dependencias del sistema: Git, SQLite, build-base y Python
RUN apk add --no-cache \
    git \
    sqlite \
    sqlite-dev \
    build-base \
    python3 \
    make \
    g++

# Instala code-server globalmente con permisos
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Crea un directorio de trabajo para code-server
WORKDIR /root/project

# Expone el puerto que code-server utiliza por defecto
EXPOSE 8080

# Comando por defecto para iniciar code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "."]

