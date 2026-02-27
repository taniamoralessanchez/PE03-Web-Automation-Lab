# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # 1. MÁQUINA FRONTEND (Nginx)
  config.vm.define "frontend" do |frontend|
    frontend.vm.hostname = "frontend"
    frontend.vm.network "private_network", ip: "192.168.56.10"
    # Redirección de puerto para ver la web desde tu Windows/Mac
    frontend.vm.network "forwarded_port", guest: 80, host: 8080
    
    frontend.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "FE-Server"
    end

    frontend.vm.provision "shell", path: "scripts/frontend.sh"
  end
  
  # 2. MÁQUINA BASE DE DATOS (MongoDB)
  config.vm.define "database" do |database|
    database.vm.hostname = "mongo"
    database.vm.network "private_network", ip: "192.168.56.30"
    
    database.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "DB-Server"
    end

    database.vm.provision "shell", path: "scripts/database.sh"
  end

  # 3. MÁQUINA BACKEND (Node.js)
  config.vm.define "backend" do |backend|
    backend.vm.hostname = "backend"
    backend.vm.network "private_network", ip: "192.168.56.20"
    
    backend.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "BE-Server"
    end

    backend.vm.provision "shell", path: "scripts/backend.sh"
  end
end