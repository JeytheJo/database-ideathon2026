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
