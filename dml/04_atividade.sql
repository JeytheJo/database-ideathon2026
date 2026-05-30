-- depende de 03_aula.sql ter rodado

-- Aula 1
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (1, 'Qual tag HTML define o título principal de uma página?', '<h1>', 'multipla_escolha'),
    (1, 'A tag <img> precisa de uma tag de fechamento separada.', 'Falso', 'verdadeiro_falso');

-- Aula 2
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (2, 'Qual propriedade CSS é usada para alinhar itens no eixo principal do Flexbox?', 'justify-content', 'multipla_escolha'),
    (2, 'Explique a diferença entre display: flex e display: grid.', 'Flex é unidimensional (linha ou coluna); Grid é bidimensional (linhas e colunas simultaneamente).', 'dissertativa');

-- Aula 3
INSERT INTO ATIVIDADE (id_aula, pergunta, resposta_correta, tipo) VALUES
    (3, 'O que a palavra-chave await faz dentro de uma função async?', 'Pausa a execução da função até que a Promise seja resolvida, sem bloquear a thread principal.', 'dissertativa'),
    (3, 'Uma Promise pode estar em três estados: pending, fulfilled e rejected.', 'Verdadeiro', 'verdadeiro_falso');
