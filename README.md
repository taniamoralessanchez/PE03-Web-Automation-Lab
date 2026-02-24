## PE03 - Web Automation Lab

Este proyecto es un pequeño laboratorio de automatización de infraestructura web usando **Vagrant** y **VirtualBox**.  
Levanta una aplicación tipo *Gestor de Tareas* basada en stack **Node.js + MongoDB**, con un **frontend Nginx** que sirve una página HTML estática.

### Objetivos del laboratorio

- **Practicar Vagrant**: definir y levantar varias máquinas virtuales desde un único `Vagrantfile`.
- **Automatizar provisión**: instalar y configurar Nginx, Node.js y MongoDB mediante *provisioners* de tipo `shell`.
- **Entender una arquitectura simple** de 3 capas:
  - **Frontend** (Nginx) sirviendo un `index.html`.
  - **Backend** (Express) exponiendo una API REST para tareas.
  - **Database** (MongoDB) almacenando los datos de las tareas.

---

### Estructura del proyecto

PE03-Web-Automation-Lab/
├── Vagrantfile
├── app/
│   ├── frontend/
│   │   └── index.html
│   └── backend/
│       └── server.js
├── scripts/
│   ├── frontend.sh
│   ├── backend.sh
│   └── database.sh
├── screenshots/
│   ├── prueba_app_funciona.png
│   ├── prueba_navegador.png
│   └── resultado_en _db.png
└── .vagrant/

---

### Requisitos previos

En el **host (tu máquina Windows/macOS/Linux)** necesitas:

- **Vagrant** (recomendado 2.x o superior).
- **VirtualBox** (u otro proveedor compatible configurado en el `Vagrantfile`, por defecto VirtualBox).
- Al menos **4 GB de RAM libres**, ya que se levantan 3 VMs ligeras.

Asegúrate también de que:

- El directorio del proyecto es accesible (en este caso `PE03-Web-Automation-Lab`).
- Los binarios `vagrant` y `virtualbox` están en tu `PATH`.

---

### Puesta en marcha

1. **Clonar o copiar** este proyecto en tu máquina. Si usas Git:

   ```bash
   git clone https://github.com/taniamoralessanchez/PE03-Web-Automation-Lab.git
   
   ```

2. Abrir una terminal en la carpeta del proyecto (si no lo has hecho ya), por ejemplo:

   - En **Windows**: usar PowerShell o CMD y navegar con `cd` hasta la ruta del proyecto.
   - En **macOS/Linux**: abrir una terminal y situarte en la carpeta donde clonaste el repositorio.

cd PE03-Web-Automation-Lab

3. **Levantar las máquinas** con Vagrant:

   ```bash
   vagrant up
   ```

   Esto descargará la box `ubuntu/bionic64` (solo la primera vez) y ejecutará los scripts de provisión:
   - `scripts/frontend.sh`
   - `scripts/backend.sh`
   - `scripts/database.sh`

4. Una vez que el comando termine sin errores, podrás:

   - Acceder al **Frontend (Nginx)** desde tu host en:

     `http://localhost:8080`

   - (Opcional) Acceder directamente al **Backend** desde la red privada:

     `http://192.168.56.20:3000/tareas`

   - El **MongoDB** escucha en la VM `database` en la IP:

     `192.168.56.30:27017`

---

### Cómo funciona la aplicación

- El **frontend** (`index.html`) se sirve desde Nginx en la VM `frontend`.  
  Desde esa página puedes:
  - Ver la **lista de tareas**.
  - **Añadir nuevas tareas** mediante un formulario.

- El **backend** (`server.js`) es una aplicación Node.js con Express:
  - Se conecta a MongoDB en `mongodb://192.168.56.30:27017/mi_proyecto`.
  - Define un modelo `Tarea` muy simple (`{ nombre: String }`).
  - Endpoints:
    - `GET /tareas` → devuelve todas las tareas.
    - `POST /tareas` → crea una tarea nueva.

- La **base de datos** (MongoDB) se instala en la VM `database`:
  - Se configura para escuchar en `0.0.0.0` para que la VM `backend` pueda conectarse.
  - El servicio `mongod` se habilita y arranca automáticamente.

---

### Comandos útiles de Vagrant

- **Levantar todo el entorno**:

  ```bash
  vagrant up
  ```

- **Ver el estado de las VMs**:

  ```bash
  vagrant status
  ```

- **Entrar por SSH a una VM concreta**:

  ```bash
  vagrant ssh frontend
  vagrant ssh backend
  vagrant ssh database
  ```

- **Re-provisionar una VM** (por ejemplo, si cambias un script):

  ```bash
  vagrant provision backend
  ```

- **Apagar las VMs**:

  ```bash
  vagrant halt
  ```

- **Destruir las VMs** (elimina las máquinas, pero no borra tu código en la carpeta del proyecto):

  ```bash
  vagrant destroy
  ```

---

### Notas y resolución de problemas

- Si `vagrant up` falla por temas de red o descarga de paquetes, vuelve a ejecutar el comando cuando tu conexión sea estable.
- Si cambias el código del backend (`server.js`), puedes:
  - Volver a provisionar la VM backend (`vagrant provision backend`), o
  - Entrar por SSH (`vagrant ssh backend`) y reiniciar manualmente el proceso Node.
- Verifica que **ningún otro servicio** esté usando el puerto `8080` en tu host si no puedes acceder a `http://localhost:8080`.
 
Al final, en la carpeta `screenshots/` se incluyen tres capturas de verificación del laboratorio:  
- `prueba_navegador.png`: muestra el acceso correcto al frontend desde el navegador del host.  
- `prueba_app_funciona.png`: muestra la aplicación de tareas funcionando (alta y listado de tareas).  
- `resultado_en _db.png`: muestra el resultado de las inserciones en la base de datos MongoDB dentro de la VM `database`. 