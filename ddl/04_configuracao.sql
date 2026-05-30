-- DROP TABLE IF EXISTS CONFIGURACAO CASCADE;

-- UNIQUE em id_usuario garante relação 1:1 com USUARIO
CREATE TABLE CONFIGURACAO (
    id_config           SERIAL       PRIMARY KEY,
    id_usuario          INT          NOT NULL UNIQUE,
    alto_contraste      BOOLEAN      DEFAULT FALSE,
    texto_ampliado      BOOLEAN      DEFAULT FALSE,
    sensibilidade_toque DECIMAL(3,2) DEFAULT 1.00
                            CHECK (sensibilidade_toque BETWEEN 0.50 AND 2.00),
    modo_voz            BOOLEAN      DEFAULT FALSE,

    CONSTRAINT fk_config_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
);

CREATE INDEX idx_config_usuario ON CONFIGURACAO(id_usuario);
