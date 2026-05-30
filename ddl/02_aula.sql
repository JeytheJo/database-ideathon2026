-- DROP TABLE IF EXISTS AULA CASCADE;

CREATE TABLE AULA (
    id_aula  SERIAL       PRIMARY KEY,
    titulo   VARCHAR(150) NOT NULL,
    descricao TEXT,
    nivel    VARCHAR(20)  NOT NULL
                 CHECK (nivel IN ('basico', 'intermediario', 'avancado'))
);

CREATE INDEX idx_aula_nivel ON AULA(nivel);
