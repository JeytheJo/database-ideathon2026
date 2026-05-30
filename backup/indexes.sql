-- USUARIO
CREATE INDEX idx_usuario_email         ON USUARIO(email);
CREATE INDEX idx_usuario_nascimento    ON USUARIO(data_nascimento);

-- AULA
CREATE INDEX idx_aula_nivel            ON AULA(nivel);

-- ATIVIDADE
CREATE INDEX idx_atividade_aula        ON ATIVIDADE(id_aula);
CREATE INDEX idx_atividade_tipo        ON ATIVIDADE(tipo);

-- CONFIGURACAO
CREATE INDEX idx_config_usuario        ON CONFIGURACAO(id_usuario);

-- TESTE_NIVELAMENTO
CREATE INDEX idx_teste_usuario         ON TESTE_NIVELAMENTO(id_usuario);
CREATE INDEX idx_teste_data            ON TESTE_NIVELAMENTO(data_realizacao);

-- USUARIO_AULA
CREATE INDEX idx_ua_usuario            ON USUARIO_AULA(id_usuario);
CREATE INDEX idx_ua_aula               ON USUARIO_AULA(id_aula);
CREATE INDEX idx_ua_concluida          ON USUARIO_AULA(concluida);

-- USUARIO_ATIVIDADE
CREATE INDEX idx_uatv_usuario          ON USUARIO_ATIVIDADE(id_usuario);
CREATE INDEX idx_uatv_atividade        ON USUARIO_ATIVIDADE(id_atividade);

-- ============================================================

