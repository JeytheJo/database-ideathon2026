-- Progresso de cada usuário: total de aulas, concluídas e em andamento
SELECT
    u.nome,
    COUNT(ua.id_aula)                                      AS total_aulas,
    SUM(CASE WHEN ua.concluida = TRUE  THEN 1 ELSE 0 END)  AS concluidas,
    SUM(CASE WHEN ua.concluida = FALSE THEN 1 ELSE 0 END)  AS em_andamento
FROM USUARIO u
LEFT JOIN USUARIO_AULA ua ON u.id_usuario = ua.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY concluidas DESC;


-- Aulas mais acessadas com total de alunos e quantos já concluíram
SELECT
    a.titulo,
    a.nivel,
    COUNT(ua.id_usuario)                                    AS total_alunos,
    SUM(CASE WHEN ua.concluida = TRUE THEN 1 ELSE 0 END)    AS concluiram
FROM AULA a
LEFT JOIN USUARIO_AULA ua ON a.id_aula = ua.id_aula
GROUP BY a.id_aula, a.titulo, a.nivel
ORDER BY total_alunos DESC;
