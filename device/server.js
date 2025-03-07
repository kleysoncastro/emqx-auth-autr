import express from "express";
const app = express();
const port = 3000;

app.use(express.json());

app.post('/device/status', (req, res) => {

    console.log(req.body);
  res.status(200).send({
    device: 'offline'
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});