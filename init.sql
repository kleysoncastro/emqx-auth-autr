CREATE TYPE ACTION AS ENUM('publish','subscribe','all');
CREATE TYPE PERMISSION AS ENUM('allow','deny');

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

CREATE INDEX mqtt_acl_username_idx ON mqtt_acl(username);

INSERT INTO mqtt_acl(username,password_hash, permission, action, topic, ipaddress, qos, retain) VALUES ('cliente1','55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251', 'allow', 'all', '["/allca/bridge", "/allca/confirm"]', '192.168.1.7', 1, 0);
INSERT 0 1



SELECT permission, action, topic, ipaddress, qos, retain FROM mqtt_acl WHERE username = ${username};

SELECT action, permission, topic FROM mqtt_acl where username = ${username}

SELECT action, permission, jsonb_array_elements_text(topic) AS topic FROM mqtt_acl WHERE username = ${username}


SELECT password_hash FROM mqtt_acl where username = ${username} LIMIT 1