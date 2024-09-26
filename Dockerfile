# Usa una imagen base de Debian Slim (más ligera)
FROM debian:bookworm-slim

# Establece el entorno como no interactivo
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza el sistema e instala Node.js, npm, git y SQLite3
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sqlite3 \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala code-server con permisos globales
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Crea un directorio de trabajo para code-server
WORKDIR /root/project

# Expone el puerto 8080 (donde code-server estará escuchando)
EXPOSE 8080

# Establece una contraseña para iniciar sesión en code-server
ENV PASSWORD=my_secure_password

# Inicia code-server cuando el contenedor esté en ejecución
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "--disable-telemetry"]
