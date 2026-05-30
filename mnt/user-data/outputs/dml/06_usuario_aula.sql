-- depende de 01_usuario.sql e 03_aula.sql terem rodado
INSERT INTO USUARIO_AULA (id_usuario, id_aula, concluida) VALUES
    (1, 1, TRUE),
    (1, 2, FALSE);
