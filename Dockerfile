FROM ghcr.io/coder/code-server:latest

# Instala fixuid
RUN apt-get update && apt-get install -y fixuid

# Copia el script fixuid al contenedor
COPY fixuid /usr/local/bin/fixuid

# Asegúrate de que fixuid sea propiedad de root y tenga el bit setuid
RUN chown root:root /usr/local/bin/fixuid && chmod u+s /usr/local/bin/fixuid

# Establece el directorio de trabajo
WORKDIR /home/coder/project

# Expone el puerto
EXPOSE 8080

# Inicia el código
CMD ["code-server", "--host", "0.0.0.0", "--port", "8080", "--auth", "password", "--password", "$PASSWORD"]
