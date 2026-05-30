-- DROP TABLE IF EXISTS TESTE_NIVELAMENTO CASCADE;

CREATE TABLE TESTE_NIVELAMENTO (
    id_teste        SERIAL      PRIMARY KEY,
    id_usuario      INT         NOT NULL,
    nivel_detectado VARCHAR(20) NOT NULL
                        CHECK (nivel_detectado IN ('basico', 'intermediario', 'avancado')),
    data_realizacao TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_teste_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
);

CREATE INDEX idx_teste_usuario ON TESTE_NIVELAMENTO(id_usuario);
CREATE INDEX idx_teste_data    ON TESTE_NIVELAMENTO(data_realizacao);
