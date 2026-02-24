const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// IP de la máquina Database definida en tu Vagrantfile
const mongoURI = 'mongodb://192.168.56.30:27017/mi_proyecto';

// Conexión limpia (sin opciones obsoletas para evitar el MongoParseError)
mongoose.connect(mongoURI)
  .then(() => console.log('>>> Conexión exitosa con MongoDB en 192.168.56.30'))
  .catch(err => console.error('>>> Error crítico de conexión:', err));

// Definición del modelo
const Tarea = mongoose.model('Tarea', { nombre: String });

// Ruta GET para listar tareas
app.get('/tareas', async (req, res) => {
  try {
    const tareas = await Tarea.find();
    res.json(tareas);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener datos de la DB" });
  }
});

// Ruta POST para añadir tareas
app.post('/tareas', async (req, res) => {
  try {
    const nuevaTarea = new Tarea({ nombre: req.body.nombre });
    await nuevaTarea.save();
    res.json(nuevaTarea);
  } catch (error) {
    res.status(500).json({ error: "Error al guardar en la DB" });
  }
});

// IMPORTANTE: Escuchar en 0.0.0.0 para permitir conexiones externas
app.listen(3000, '0.0.0.0', () => {
  console.log('>>> Servidor Backend listo en http://192.168.56.20:3000');
});