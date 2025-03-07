# Autenticação e autorização no broker emqx usando postgresql

## A tabela mqtt_acl é usada para auth e autori

Enums para delimitação de atividades no brocker

```sql
CREATE TYPE ACTION AS ENUM('publish','subscribe','all');
```

Enums para autorização

```sql
CREATE TYPE PERMISSION AS ENUM('allow','deny');
```

Tabela principal para autorização

```sql
CREATE TABLE mqtt_acl (
  id SERIAL PRIMARY KEY,
  ipaddress CHARACTER VARYING(60) NOT NULL DEFAULT '',
  username CHARACTER VARYING(255) NOT NULL DEFAULT '',
  password_hash CHARACTER VARYING(255) NOT NULL DEFAULT '',
  clientid CHARACTER VARYING(255) NOT NULL DEFAULT '',
  action ACTION,
  permission PERMISSION,
  topic JSONB NOT NULL,
  qos SMALLINT,
  retain SMALLINT
);
```

Criando index para buscas mais rapidas

```sql
CREATE INDEX mqtt_acl_username_idx ON mqtt_acl(username);
```

Dados para testes
Hash sha256 de `senha123`

```sql

INSERT INTO mqtt_acl(username,password_hash, permission, action, topic, ipaddress, qos, retain) VALUES ('cliente1','sha_de_senha123', 'allow', 'all', '["/allca/bridge", "/allca/confirm"]','192.168.1.7', 1, 0);
INSERT 0 1
```

### Select de testes

### Query de autorização para lista de topicos em json

```sql
SELECT action, permission, jsonb_array_elements_text(topic) AS topic FROM mqtt_acl WHERE username = ${username}
```

```sql
SELECT permission, action, topic, ipaddress, qos, retain FROM mqtt_acl WHERE username = ${username};
```

```sql
SELECT action, permission, topic FROM mqtt_acl where username = ${username}
```

Teste para autenticação

```sql
SELECT password_hash FROM mqtt_acl where username = ${username} LIMIT 1
```

Query para obter a lista de topic cadastrdos

```sql
SELECT action, permission, jsonb_array_elements_text(topic) AS topic FROM mqtt_acl WHERE username = ${username}
```

### No arquivo de ACL em autorização

habilitar  `{deny, all}.` para bloquear acesso sem passar pelo posrgresql
