# Usar la imagen base de Ubuntu
FROM ubuntu:22.04

# Actualizar los repositorios e instalar dependencias
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js v20 y npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Verificar las versiones instaladas
RUN node -v && npm -v && git --version


ENV VERSION=4.93.1

# Descargar e instalar code-server usando el archivo .deb
RUN curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb && \
    apt-get install -y ./code-server_${VERSION}_amd64.deb && \
    rm code-server_${VERSION}_amd64.deb

# Exponer el puerto que utilizará code-server
EXPOSE 8080

# Configurar la variable de entorno para la contraseña
ENV PASS="kachina"  

# Comando para ejecutar code-server con autenticación usando la variable de entorno PASS
CMD ["sh", "-c", "code-server --host 0.0.0.0 --port 8080 --auth password --password \"$PASS\""]
