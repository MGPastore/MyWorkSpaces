# Usa la imagen base de Alpine, más ligera que Ubuntu
FROM alpine:latest

# Establece el idioma y la localización
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Instala dependencias: curl, git, nodejs, npm y sqlite3
RUN apk update && apk add --no-cache \
    curl \
    git \
    nodejs \
    npm \
    sqlite \
    bash \
    && rm -rf /var/cache/apk/*

# Instala code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Establece una contraseña para iniciar sesión en code-server
ENV PASSWORD=kachinateamo

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto de code-server
EXPOSE 8080

# Inicia code-server con autenticación de contraseña
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]