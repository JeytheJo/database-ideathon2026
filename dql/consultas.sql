-- Usuário
-- Todos os usuários com seu nível atual (último teste feito)
SELECT
    u.id_usuario,
    u.nome,
    u.email,
    (
        SELECT tn.nivel_detectado
        FROM TESTE_NIVELAMENTO tn
        WHERE tn.id_usuario = u.id_usuario
        ORDER BY tn.data_realizacao DESC
        LIMIT 1
    ) AS nivel_atual
FROM USUARIO u
ORDER BY u.nome;


-- Usuários que nunca fizeram teste de nivelamento
-- útil pra notificar
SELECT u.nome, u.email
FROM USUARIO u
WHERE NOT EXISTS (
    SELECT 1
    FROM TESTE_NIVELAMENTO tn
    WHERE tn.id_usuario = u.id_usuario
);

-- AULAS E PROGRESSO

-- Progresso de cada usuário: total de aulas, concluídas e em andamento
SELECT
    u.nome,
    COUNT(ua.id_aula)                                        AS total_aulas,
    SUM(CASE WHEN ua.concluida = TRUE  THEN 1 ELSE 0 END)    AS concluidas,
    SUM(CASE WHEN ua.concluida = FALSE THEN 1 ELSE 0 END)    AS em_andamento
FROM USUARIO u
LEFT JOIN USUARIO_AULA ua ON u.id_usuario = ua.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY concluidas DESC;


-- Aulas mais acessadas, com total de alunos e quantos já concluíram
SELECT
    a.titulo,
    a.nivel,
    COUNT(ua.id_usuario)                                      AS total_alunos,
    SUM(CASE WHEN ua.concluida = TRUE THEN 1 ELSE 0 END)      AS concluiram
FROM AULA a
LEFT JOIN USUARIO_AULA ua ON a.id_aula = ua.id_aula
GROUP BY a.id_aula, a.titulo, a.nivel
ORDER BY total_alunos DESC;


-- ATIVIDADES E DESEMPENHO

-- Taxa de acerto por usuário
-- NULLIF evita divisão por zero caso o usuário não tenha respondido nada
SELECT
    u.nome,
    COUNT(ua.id_atividade)                                    AS respondidas,
    SUM(CASE WHEN ua.acertou = TRUE THEN 1 ELSE 0 END)        AS acertos,
    ROUND(
        SUM(CASE WHEN ua.acertou = TRUE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(ua.id_atividade), 0), 2
    )                                                         AS pct_acerto
FROM USUARIO u
LEFT JOIN USUARIO_ATIVIDADE ua ON u.id_usuario = ua.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY pct_acerto DESC;


-- Atividades com maior taxa de erro — indica quais conteúdos precisam revisão
SELECT
    at.pergunta,
    at.tipo,
    COUNT(ua.id_usuario)                                      AS respostas,
    ROUND(
        SUM(CASE WHEN ua.acertou = FALSE THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(ua.id_usuario), 0), 2
    )                                                         AS pct_erro
FROM ATIVIDADE at
LEFT JOIN USUARIO_ATIVIDADE ua ON at.id_atividade = ua.id_atividade
GROUP BY at.id_atividade, at.pergunta, at.tipo
ORDER BY pct_erro DESC;

-- NIVELAMENTO

-- Distribuição de usuários por nível (só o teste mais recente de cada um)
SELECT
    nivel_detectado,
    COUNT(*) AS total
FROM (
    SELECT DISTINCT ON (id_usuario)
        id_usuario,
        nivel_detectado
    FROM TESTE_NIVELAMENTO
    ORDER BY id_usuario, data_realizacao DESC
) ultimo_teste
GROUP BY nivel_detectado
ORDER BY total DESC;


-- RELATÓRIO GERAL

-- Dashboard completo por usuário — visão que os bocó do back vai usar pra montar o perfil(se quiser, se n quiser n fds)
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

    (SELECT COUNT(*) FROM USUARIO_AULA      WHERE id_usuario = u.id_usuario)                    AS total_aulas,
    (SELECT COUNT(*) FROM USUARIO_AULA      WHERE id_usuario = u.id_usuario AND concluida = TRUE) AS aulas_concluidas,
    (SELECT COUNT(*) FROM USUARIO_ATIVIDADE WHERE id_usuario = u.id_usuario)                    AS atividades_feitas,
    (SELECT COUNT(*) FROM USUARIO_ATIVIDADE WHERE id_usuario = u.id_usuario AND acertou = TRUE)  AS atividades_corretas

FROM USUARIO u
LEFT JOIN CONFIGURACAO c ON u.id_usuario = c.id_usuario
ORDER BY u.nome;