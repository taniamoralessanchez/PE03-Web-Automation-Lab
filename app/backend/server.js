const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();

// Middlewares vitales
app.use(cors()); 
app.use(express.json());

// IP de tu máquina Database
const mongoURI = 'mongodb://192.168.56.30:27017/mi_proyecto';


mongoose.connect(mongoURI)
  .then(() => console.log('>>> CONECTADO A MONGODB OK'))
  .catch(err => console.error('>>> ERROR DE CONEXIÓN:', err));

// Modelo de datos
const Tarea = mongoose.model('Tarea', { nombre: String });

// Rutas
app.get('/tareas', async (req, res) => {
  const tareas = await Tarea.find();
  res.json(tareas);
});

app.post('/tareas', async (req, res) => {
  const nuevaTarea = new Tarea({ nombre: req.body.nombre });
  await nuevaTarea.save();
  res.json(nuevaTarea);
});

// Escuchar en 0.0.0.0 es obligatorio para recibir peticiones externas
app.listen(3000, '0.0.0.0', () => {
  console.log('>>> SERVIDOR LISTO EN EL PUERTO 3000');
});