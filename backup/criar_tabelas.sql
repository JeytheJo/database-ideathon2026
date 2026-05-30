-- LIMPEZA (rodar só se quiser recriar do zero)
-- ============================================================
-- DROP TABLE IF EXISTS USUARIO_AULA     CASCADE;
-- DROP TABLE IF EXISTS USUARIO_ATIVIDADE CASCADE;
-- DROP TABLE IF EXISTS ATIVIDADE        CASCADE;
-- DROP TABLE IF EXISTS AULA             CASCADE;
-- DROP TABLE IF EXISTS CONFIGURACAO     CASCADE;
-- DROP TABLE IF EXISTS TESTE_NIVELAMENTO CASCADE;
-- DROP TABLE IF EXISTS USUARIO          CASCADE;


-- Entidade central do sistema
-- ============================================================
CREATE TABLE USUARIO (
    id_usuario      SERIAL          PRIMARY KEY,
    nome            VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    senha           VARCHAR(255)    NOT NULL,          -- guardar hash, nunca texto puro
    data_nascimento DATE            NOT NULL,
    data_cadastro   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);

-- Conteúdo educacional disponível no app
-- ============================================================
CREATE TABLE AULA (
    id_aula     SERIAL          PRIMARY KEY,
    titulo      VARCHAR(150)    NOT NULL,
    descricao   TEXT,
    nivel       VARCHAR(20)     NOT NULL
                    CHECK (nivel IN ('basico', 'intermediario', 'avancado'))
);


-- Questões vinculadas a uma aula (pertence a AULA)
-- ============================================================
CREATE TABLE ATIVIDADE (
    id_atividade        SERIAL          PRIMARY KEY,
    id_aula             INT             NOT NULL,
    pergunta            TEXT            NOT NULL,
    resposta_correta    TEXT            NOT NULL,
    tipo                VARCHAR(50)     NOT NULL
                            CHECK (tipo IN ('multipla_escolha', 'verdadeiro_falso', 'dissertativa')),

    CONSTRAINT fk_atividade_aula
        FOREIGN KEY (id_aula) REFERENCES AULA(id_aula)
        ON DELETE CASCADE
);


-- Preferências de acessibilidade do usuário (1:1 com USUARIO)
-- ============================================================
CREATE TABLE CONFIGURACAO (
    id_config               SERIAL          PRIMARY KEY,
    id_usuario              INT             NOT NULL UNIQUE,   -- UNIQUE garante 1:1
    alto_contraste          BOOLEAN         DEFAULT FALSE,
    texto_ampliado          BOOLEAN         DEFAULT FALSE,
    sensibilidade_toque     DECIMAL(3,2)    DEFAULT 1.00
                                CHECK (sensibilidade_toque BETWEEN 0.50 AND 2.00),
    modo_voz                BOOLEAN         DEFAULT FALSE,

    CONSTRAINT fk_config_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
);


-- Testes realizados pelo usuário (1:N com USUARIO)
-- ============================================================
CREATE TABLE TESTE_NIVELAMENTO (
    id_teste            SERIAL          PRIMARY KEY,
    id_usuario          INT             NOT NULL,
    nivel_detectado     VARCHAR(20)     NOT NULL
                            CHECK (nivel_detectado IN ('basico', 'intermediario', 'avancado')),
    data_realizacao     TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_teste_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
);


-- Relacionamento N:N entre USUARIO e AULA (assiste)
-- ============================================================
CREATE TABLE USUARIO_AULA (
    id_usuario      INT         NOT NULL,
    id_aula         INT         NOT NULL,
    data_inicio     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    concluida       BOOLEAN     DEFAULT FALSE,

    PRIMARY KEY (id_usuario, id_aula),

    CONSTRAINT fk_ua_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    CONSTRAINT fk_ua_aula
        FOREIGN KEY (id_aula) REFERENCES AULA(id_aula)
        ON DELETE CASCADE
);

-- Relacionamento N:N entre USUARIO e ATIVIDADE (realiza)
-- ============================================================
CREATE TABLE USUARIO_ATIVIDADE (
    id_usuario          INT         NOT NULL,
    id_atividade        INT         NOT NULL,
    resposta_dada       TEXT,
    acertou             BOOLEAN,
    data_realizacao     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_usuario, id_atividade),

    CONSTRAINT fk_uatv_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE,

    CONSTRAINT fk_uatv_atividade
        FOREIGN KEY (id_atividade) REFERENCES ATIVIDADE(id_atividade)
        ON DELETE CASCADE
);

-- Para popular o banco, rode: \i dml/dados_teste.sql
