# Usa la imagen base de Alpine
FROM alpine:latest

# Establece el idioma y la localización
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Instala dependencias necesarias
RUN apk update && apk add --no-cache \
    curl \
    git \
    nodejs \
    npm \
    sqlite \
    python3 \
    make \
    g++ \
    bash \
    && rm -rf /var/cache/apk/*

# Instala code-server utilizando npm, con todas las dependencias necesarias
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Establece una contraseña para iniciar sesión en code-server
ENV PASSWORD=kachinateamo

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto de code-server
EXPOSE 8080

# Inicia code-server con autenticación de contraseña
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password"]
