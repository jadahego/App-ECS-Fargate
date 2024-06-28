# Usar una imagen base de Python
FROM python:3.8-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo requirements.txt al directorio de trabajo
COPY requirements.txt .

# Actualizar pip e instalar las dependencias
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copiar el resto de la aplicación al directorio de trabajo
COPY . .

# Exponer el puerto en el que la aplicación correrá
EXPOSE 5000

# Configurar el comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]
