-- DROP TABLE IF EXISTS ATIVIDADE CASCADE;

CREATE TABLE ATIVIDADE (
    id_atividade     SERIAL      PRIMARY KEY,
    id_aula          INT         NOT NULL,
    pergunta         TEXT        NOT NULL,
    resposta_correta TEXT        NOT NULL,
    tipo             VARCHAR(50) NOT NULL
                         CHECK (tipo IN ('multipla_escolha', 'verdadeiro_falso', 'dissertativa')),

    CONSTRAINT fk_atividade_aula
        FOREIGN KEY (id_aula) REFERENCES AULA(id_aula)
        ON DELETE CASCADE
);

CREATE INDEX idx_atividade_aula ON ATIVIDADE(id_aula);
CREATE INDEX idx_atividade_tipo ON ATIVIDADE(tipo);
