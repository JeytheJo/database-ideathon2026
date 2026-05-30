-- DROP TABLE IF EXISTS USUARIO CASCADE;

CREATE TABLE USUARIO (
    id_usuario      SERIAL          PRIMARY KEY,
    nome            VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    senha           VARCHAR(255)    NOT NULL,
    data_nascimento DATE            NOT NULL,
    data_cadastro   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_usuario_email      ON USUARIO(email);
CREATE INDEX idx_usuario_nascimento ON USUARIO(data_nascimento);
