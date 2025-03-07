import * as mqtt from "mqtt";

// Configurações do broker
const brokerUrl = 'mqtt://localhost:1883';
const username = 'cliente1';
const password = 'senha123';

const id_unique = 'ff:ff:ff:ff:ff:aa';


const pyload_wlt = {
    id: id_unique,
    ipaddress: '192.168.1.7',
    time: Date.now()
};

// Cria um cliente MQTT
const client = mqtt.connect(brokerUrl, {
  username,
  password,
  clientId: id_unique,
  will: {
    topic: '/allca/confirm',
    payload: JSON.stringify(pyload_wlt),
    qos: 1,
    retain: true
  }
});

// Função para lidar com a conexão
client.on('connect', () => {
  console.log('Conectado ao broker!');

  client.publish('/allca/confirm', 'Hello, MQTT!');
});

// Função para lidar com erros
client.on('error', (err) => {
  console.error('Erro ao conectar:', err);
});

// Função para lidar com a desconexão
client.on('disconnect', () => {
  console.log('Desconectado do broker!');
});