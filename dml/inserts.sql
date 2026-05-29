-- Inserts

-- 1. USUARIO
INSERT INTO USUARIO (nome, email, senha, data_nascimento)
VALUES (
    'Álvaro Silva',
    'alvaro.silva@email.com',
    '$2b$12$KIXqz1lY0tQwP9uXn3mOreHgJ8vL7sNdRbT6WcA4pFkEoMYDuZxV2',  -- hash bcrypt fictício
    '1998-07-14'
);


-- 2. CONFIGURACAO (1:1 com o usuário acima — id_usuario = 1)
INSERT INTO CONFIGURACAO (id_usuario, alto_contraste, texto_ampliado, sensibilidade_toque, modo_voz)
VALUES (1, FALSE, TRUE, 1.25, FALSE);


-- 3. AULAS
INSERT INTO AULA (titulo, descricao, nivel) VALUES
    ('Introdução ao HTML',    'Estrutura básica de páginas web: tags, atributos e semântica.', 'basico'),
    ('CSS Responsivo',        'Flexbox, Grid e media queries para layouts adaptáveis.',         'intermediario'),
    ('JavaScript Assíncrono', 'Promises, async/await e consumo de APIs REST.',                  'avancado');



-- 4. ATIVIDADES (2 por aula)
-- ============================================================

-- Aula 1 — Introdução ao HTML (id_aula = 1)
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (1,
     'Qual tag HTML define o título principal de uma página?',
     '<h1>',
     'multipla_escolha'),
    (1,
     'A tag <img> precisa de uma tag de fechamento separada.',
     'Falso',
     'verdadeiro_falso');

-- Aula 2 — CSS Responsivo (id_aula = 2)
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (2,
     'Qual propriedade CSS é usada para alinhar itens no eixo principal do Flexbox?',
     'justify-content',
     'multipla_escolha'),
    (2,
     'Explique a diferença entre display: flex e display: grid.',
     'Flex é unidimensional (linha ou coluna); Grid é bidimensional (linhas e colunas simultaneamente).',
     'dissertativa');

-- Aula 3 — JavaScript Assíncrono (id_aula = 3)
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (3,
     'O que a palavra-chave await faz dentro de uma função async?',
     'Pausa a execução da função até que a Promise seja resolvida, sem bloquear a thread principal.',
     'dissertativa'),
    (3,
     'Uma Promise pode estar em três estados: pending, fulfilled e rejected.',
     'Verdadeiro',
     'verdadeiro_falso');


-- 5. TESTE DE NIVELAMENTO
INSERT INTO TESTE_NIVELAMENTO (id_usuario, nivel_detectado)
VALUES (1, 'intermediario');


-- 6. USUARIO_AULA (Álvaro assistiu às aulas 1 e 2; aula 1 já concluída)
INSERT INTO USUARIO_AULA (id_usuario, id_aula, concluida) VALUES
    (1, 1, TRUE),
    (1, 2, FALSE);


-- 7. USUARIO_ATIVIDADE (Álvaro respondeu às atividades da aula 1)
INSERT INTO USUARIO_ATIVIDADE (id_usuario, id_atividade, resposta_dada, acertou) VALUES
    (1, 1, '<h1>',  TRUE),
    (1, 2, 'Verdadeiro', FALSE);  -- errou: a resposta correta era Falso