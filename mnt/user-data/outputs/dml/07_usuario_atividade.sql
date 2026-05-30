-- depende de 01_usuario.sql e 04_atividade.sql terem rodado
INSERT INTO USUARIO_ATIVIDADE (id_usuario, id_atividade, resposta_dada, acertou) VALUES
    (1, 1, '<h1>', TRUE),
    (1, 2, 'Verdadeiro', FALSE);  -- errou: a resposta correta era Falso
