-- DROP TABLE IF EXISTS USUARIO_ATIVIDADE CASCADE;

-- Tabela associativa N:N: registra as respostas de cada usuário por atividade
CREATE TABLE USUARIO_ATIVIDADE (
    id_usuario      INT       NOT NULL,
    id_atividade    INT       NOT NULL,
    resposta_dada   TEXT,
    acertou         BOOLEAN,
    data_realizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_usuario, id_atividade),

    CONSTRAINT fk_uatv_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    CONSTRAINT fk_uatv_atividade
        FOREIGN KEY (id_atividade) REFERENCES ATIVIDADE(id_atividade)
        ON DELETE CASCADE
);

CREATE INDEX idx_uatv_usuario    ON USUARIO_ATIVIDADE(id_usuario);
CREATE INDEX idx_uatv_atividade  ON USUARIO_ATIVIDADE(id_atividade);
