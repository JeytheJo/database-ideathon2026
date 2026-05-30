-- DROP TABLE IF EXISTS USUARIO_AULA CASCADE;

-- Tabela associativa N:N: um usuário pode assistir várias aulas
CREATE TABLE USUARIO_AULA (
    id_usuario  INT       NOT NULL,
    id_aula     INT       NOT NULL,
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    concluida   BOOLEAN   DEFAULT FALSE,

    PRIMARY KEY (id_usuario, id_aula),

    CONSTRAINT fk_ua_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    CONSTRAINT fk_ua_aula
        FOREIGN KEY (id_aula) REFERENCES AULA(id_aula)
        ON DELETE CASCADE
);

CREATE INDEX idx_ua_usuario  ON USUARIO_AULA(id_usuario);
CREATE INDEX idx_ua_aula     ON USUARIO_AULA(id_aula);
CREATE INDEX idx_ua_concluida ON USUARIO_AULA(concluida);
