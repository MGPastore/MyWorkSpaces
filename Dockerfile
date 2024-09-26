# Usar la imagen base de Node.js
FROM node:20

# Crear un directorio de trabajo
WORKDIR /app

# Instalar git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

# Instalar code-server globalmente
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Exponer el puerto que utilizará code-server
EXPOSE 8080

# Comando para ejecutar code-server con autenticación usando la variable de entorno PASSWORD
CMD ["sh", "-c", "node -v && npm -v && git --version && code-server --host 0.0.0.0 --port 8080 --auth password --password \"kachina\""]
