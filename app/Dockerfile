# Usar una imagen base ligera
FROM python:3.8-slim

# Establecer el directorio de trabajo
WORKDIR ./app

# Copiar y instalar dependencias
COPY requirements.txt ./app
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Copiar el resto de la aplicación
COPY ./app

# Exponer el puerto en el que la aplicación correrá
EXPOSE 3000

# Configurar el comando por defecto para ejecutar la aplicación
CMD ["venv/bin/python", "app.py"]
