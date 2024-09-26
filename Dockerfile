# Usar la imagen base de Ubuntu
FROM ubuntu:20.04

# Instalar dependencias
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get install -y software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y npm

# Crear un directorio de trabajo
WORKDIR /app

# Instalar code-server globalmente
RUN curl -fOL https://github.com/coder/code-server/releases/download/v4.93.1/code-server_4.93.1_amd64.deb && \
    dpkg -i code-server_4.93.1_amd64.deb && \
    apt-get install -f

# Exponer el puerto que utilizará code-server
EXPOSE 8080

# Copiar el archivo de configuración de code-server
RUN mkdir -p ~/.config/code-server && \
    echo "bind-addr: 0.0.0.0:8080\npassword: ${PASSWORD}\n" > ~/.config/code-server/config.yaml

# Comando para ejecutar code-server
CMD ["code-server"]
