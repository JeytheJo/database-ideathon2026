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


-- Usuários que nunca fizeram teste de nivelamento — útil pra notificar
SELECT u.nome, u.email
FROM USUARIO u
WHERE NOT EXISTS (
    SELECT 1 FROM TESTE_NIVELAMENTO tn
    WHERE tn.id_usuario = u.id_usuario
);
