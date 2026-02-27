#!/bin/bash

echo ">>> Instalando Node.js en la VM Backend..."
# 1. Instalar Node.js
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

echo ">>> Preparando carpeta de la aplicación..."
# 2. Crear carpeta y asegurar que el usuario vagrant tenga permisos
sudo mkdir -p /home/vagrant/app
sudo chown -R vagrant:vagrant /home/vagrant/app
cd /home/vagrant/app

# 3. Copiar los archivos desde la carpeta compartida de Vagrant
cp /vagrant/app/backend/* .

echo ">>> Instalando dependencias (esto puede tardar un poco)..."
# 4. Instalar dependencias
npm install express mongoose cors

echo ">>> Iniciando el servidor de forma persistente..."
# 5. Matar procesos anteriores en el puerto 3000 si los hubiera (para evitar errores al reprovisionar)
sudo fuser -k 3000/tcp || true

# 6. Lanzar la aplicación
# Usamos nohup, redirigimos logs y usamos '&' + 'disown' para que no se cierre al salir el script
(cd /home/vagrant/app && nohup node server.js > output.log 2>&1 &) && sleep 1 && disown -a

# 7. Una pequeña espera para que a Node le dé tiempo a arrancar antes de que el script termine
sleep 5

echo ">>> Backend iniciado y desvinculado. Logs en /home/vagrant/app/output.log"