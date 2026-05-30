-- Taxa de acerto por usuário
-- NULLIF evita divisão por zero caso o usuário não tenha respondido nada
SELECT
    u.nome,
    COUNT(ua.id_atividade)                                  AS respondidas,
    SUM(CASE WHEN ua.acertou = TRUE THEN 1 ELSE 0 END)      AS acertos,
    ROUND(
        SUM(CASE WHEN ua.acertou = TRUE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(ua.id_atividade), 0), 2
    )                                                       AS pct_acerto
FROM USUARIO u
LEFT JOIN USUARIO_ATIVIDADE ua ON u.id_usuario = ua.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY pct_acerto DESC;


-- Atividades com maior taxa de erro — indica quais conteúdos precisam revisão
SELECT
    at.pergunta,
    at.tipo,
    COUNT(ua.id_usuario)                                    AS respostas,
    ROUND(
        SUM(CASE WHEN ua.acertou = FALSE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(ua.id_usuario), 0), 2
    )                                                       AS pct_erro
FROM ATIVIDADE at
LEFT JOIN USUARIO_ATIVIDADE ua ON at.id_atividade = ua.id_atividade
GROUP BY at.id_atividade, at.pergunta, at.tipo
ORDER BY pct_erro DESC;
