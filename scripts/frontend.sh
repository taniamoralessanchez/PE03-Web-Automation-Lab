#!/bin/bash

echo ">>> Instalando Nginx en la VM Frontend..."

# 1. Actualizar e instalar Nginx
sudo apt-get update
sudo apt-get install -y nginx

# 2. Borrar el index por defecto de Nginx
sudo rm /var/www/html/index.nginx-debian.html

# 3. Copiar nuestro archivo index.html desde la carpeta compartida de Vagrant
# Usamos -f para forzar el sobreescrito si ya existe
sudo cp /vagrant/app/frontend/index.html /var/www/html/index.html

# 4. Ajustar permisos para que Nginx pueda leer el archivo
sudo chmod 644 /var/www/html/index.html

# 5. Reiniciar Nginx para asegurar que todo está bien
sudo systemctl restart nginx

echo ">>> Frontend listo. Accede desde tu host en http://localhost:8080"