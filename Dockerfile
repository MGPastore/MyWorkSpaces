# Usa una imagen base de Arch Linux
FROM archlinux:latest

# Actualiza el sistema e instala las dependencias necesarias
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    python \
    python-pip \
    krb5 \
    nodejs \
    npm \
    curl \
    wget \
    vim \
    && pacman -Scc --noconfirm

# Instala code-server con permisos globales (--unsafe-perm)
RUN npm install -g code-server@4.93.1 --unsafe-perm

# Crea un directorio de trabajo para code-server
WORKDIR /root/project

# Expone el puerto 8080 (donde code-server estará escuchando)
EXPOSE 8080

# Establece una contraseña para iniciar sesión en code-server
ENV PASSWORD=kachinateamo

# Inicia code-server cuando el contenedor esté en ejecución
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "--disable-telemetry"]
