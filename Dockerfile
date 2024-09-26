# Usar la imagen base de Ubuntu
FROM ubuntu:22.04

# Actualizar los repositorios y instalar dependencias
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Verificar las versiones instaladas
RUN nodejs -v && npm -v && git --version

# Instalar code-server globalmente
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Exponer el puerto que utilizará code-server
EXPOSE 8080

# Configurar la variable de entorno para la contraseña
ENV PASS="kachina"  # Cambia "your_password_here" si deseas una contraseña predeterminada

# Comando para ejecutar code-server con autenticación usando la variable de entorno PASS
CMD ["sh", "-c", "code-server --host 0.0.0.0 --port 8080 --auth password --password \"$PASS\""]
