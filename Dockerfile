# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Establecer la zona horaria
ENV TZ=America/New_York

# Instalar dependencias necesarias y configurar locales
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    sqlite3 \
    git \
    apt-transport-https \
    ca-certificates \
    tzdata \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js (versión 18.x) y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && rm -rf /var/lib/apt/lists/*

# Instalar MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - \
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" \
    > /etc/apt/sources.list.d/mongodb-org-6.0.list \
    && apt-get update \
    && apt-get install -y mongodb-org \
    && rm -rf /var/lib/apt/lists/*

# Instalar MySQL
RUN apt-get update && apt-get install -y mysql-server \
    && rm -rf /var/lib/apt/lists/*

# Agregar el repositorio de code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Establecer el directorio de trabajo
WORKDIR /home/coder/project

# Exponer puertos para code-server, MongoDB y MySQL
EXPOSE 8080 27017 3306

# Iniciar el servicio de MongoDB y code-server
CMD service mongodb start && \
    service mysql start && \
    code-server --host 0.0.0.0 --port 8080 --auth none
