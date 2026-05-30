-- Dashboard completo por usuário — visão que o back vai usar pra montar o perfil
SELECT
    u.nome,
    u.email,
    u.data_nascimento,

    c.alto_contraste,
    c.texto_ampliado,
    c.modo_voz,

    (
        SELECT tn.nivel_detectado
        FROM TESTE_NIVELAMENTO tn
        WHERE tn.id_usuario = u.id_usuario
        ORDER BY tn.data_realizacao DESC
        LIMIT 1
    ) AS nivel_atual,

    (SELECT COUNT(*) FROM USUARIO_AULA      WHERE id_usuario = u.id_usuario)                      AS total_aulas,
    (SELECT COUNT(*) FROM USUARIO_AULA      WHERE id_usuario = u.id_usuario AND concluida = TRUE)  AS aulas_concluidas,
    (SELECT COUNT(*) FROM USUARIO_ATIVIDADE WHERE id_usuario = u.id_usuario)                      AS atividades_feitas,
    (SELECT COUNT(*) FROM USUARIO_ATIVIDADE WHERE id_usuario = u.id_usuario AND acertou = TRUE)    AS atividades_corretas

FROM USUARIO u
LEFT JOIN CONFIGURACAO c ON u.id_usuario = c.id_usuario
ORDER BY u.nome;
