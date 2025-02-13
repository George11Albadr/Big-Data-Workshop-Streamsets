# Dockerfile para StreamSets Data Collector 3.22.2 con Ubuntu 20.04
# Para construir la imagen con el nombre "streamsets", ejecuta:
#    docker build -t streamsets .

FROM ubuntu:20.04

# Evitar interacción manual durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar el repositorio e instalar dependencias necesarias: OpenJDK 11, wget, curl y unzip
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Crear el usuario "streamsets" para ejecutar la aplicación
RUN useradd -m -s /bin/bash streamsets

# Descargar y configurar StreamSets Data Collector 3.22.2
RUN wget -q https://archives.streamsets.com/datacollector/3.22.2/tarball/streamsets-datacollector-core-3.22.2.tgz -O /tmp/sdc.tgz \
    && mkdir -p /opt/streamsets \
    && tar -xzf /tmp/sdc.tgz -C /opt/streamsets --strip-components=1 \
    && rm /tmp/sdc.tgz

# Crear directorio para los archivos de datasource y copiar el JSON
RUN mkdir -p /opt/streamsets/datasource
COPY datasource/ufc_championships_extended.json /opt/streamsets/datasource/

# Asignar permisos al usuario streamsets sobre la carpeta de StreamSets
RUN chown -R streamsets:streamsets /opt/streamsets

# Cambiar al usuario streamsets y definir el directorio de trabajo
USER streamsets
WORKDIR /opt/streamsets

# Exponer el puerto para la interfaz web (por defecto 18630)
EXPOSE 18630

# Comando por defecto para iniciar StreamSets Data Collector en modo "dc"
CMD ["/opt/streamsets/bin/streamsets", "dc"]