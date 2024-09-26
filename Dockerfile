# Usa una imagen base de Ubuntu
FROM ubuntu:20.04

# Establecer la variable de entorno para evitar interacciones
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias y configurar la zona horaria
RUN apt-get update && \
    apt-get install -y tzdata curl && \
    ln -fs /usr/share/zoneinfo/America/Montevideo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instalar Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Configurar el directorio de configuración de Code Server
RUN mkdir -p /home/coder && \
    echo "bind-addr: 0.0.0.0:8080" >> /home/coder/config.yaml && \
    echo "auth: password" >> /home/coder/config.yaml && \
    echo "password: mypassword" >> /home/coder/config.yaml && \
    echo "cert: false" >> /home/coder/config.yaml

# Exponer el puerto 8080 para acceder a Code Server
EXPOSE 8080

# Comando por defecto al ejecutar el contenedor
CMD ["code-server", "--config", "/home/coder/config.yaml", "--user-data-dir", "/home/coder"]
