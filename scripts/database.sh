#!/bin/bash

echo ">>> Instalando MongoDB en la VM Database..."

# 1. Importar la clave pública y añadir repositorio oficial
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# 2. Actualizar e instalar
sudo apt-get update
sudo apt-get install -y mongodb-org

# 3. Configurar MongoDB para permitir conexiones externas (CRÍTICO)
# Por defecto solo escucha en 127.0.0.1. Cambiamos a 0.0.0.0 para que el Backend llegue.
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# 4. Iniciar y habilitar el servicio
sudo systemctl start mongod
sudo systemctl enable mongod

echo ">>> MongoDB instalado y escuchando en el puerto 27017"