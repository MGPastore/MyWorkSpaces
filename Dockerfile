FROM ghcr.io/coder/code-server:latest

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Descargar fixuid y compilarlo
RUN curl -L https://github.com/vrutkovs/fixuid/releases/latest/download/fixuid -o /usr/local/bin/fixuid && \
    chmod u+s /usr/local/bin/fixuid

# Asegúrate de que fixuid sea propiedad de root y tenga el bit setuid
RUN chown root:root /usr/local/bin/fixuid && chmod u+s /usr/local/bin/fixuid

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto
EXPOSE 8080

# Inicia el código
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]
