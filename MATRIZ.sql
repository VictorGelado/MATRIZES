DROP TABLE IF EXISTS curso, disciplina, matriz_ano_disciplina, matriz;

-- CURSOS
CREATE TABLE curso (
	ID SERIAL PRIMARY KEY NOT NULL,
	nome VARCHAR(200) NOT NULL,
	campus VARCHAR(150) NOT NULL,
	periodo VARCHAR(15) NOT NULL
);

-- DISCIPLINA
CREATE TABLE disciplina (
	ID SERIAL PRIMARY KEY NOT NULL,
	nome VARCHAR(150) NOT NULL,
	codigo VARCHAR(20) NOT NULL,
	nucleo VARCHAR(20) NOT NULL,
	casep NUMERIC(5, 2) NOT NULL,
	cased NUMERIC(5, 2) NOT NULL,
	castt NUMERIC(5, 2) NOT NULL, -- CAST
	chtap NUMERIC(5, 2) NOT NULL,
	chtad NUMERIC(5, 2) NOT NULL,
	chtat NUMERIC(5, 2) NOT NULL,
	qap NUMERIC(5, 2) DEFAULT 45.00 NOT NULL ,
	qaead NUMERIC(5, 2) DEFAULT 0.00
);

-- RELACIONAMENTO ENTRE MATRIZ E MATÉRIAS (POR ANOS TAMBÉM)
CREATE TABLE matriz_ano_disciplina (
	ID SERIAL PRIMARY KEY,
	disciplina_ID INT NOT NULL,
	ano INT NOT NULL,
	FOREIGN KEY (disciplina_ID) REFERENCES disciplina(id)
);

-- MATRIZ
CREATE TABLE matriz (
	ID SERIAL PRIMARY KEY,
	curso_ID INT NOT NULL,
	matriz_ano_disciplina_ID INT NOT NULL,
	FOREIGN KEY (curso_ID) REFERENCES curso(id),
	FOREIGN KEY (matriz_ano_disciplina_ID) REFERENCES matriz_ano_disciplina(id)
);



-- INSERTS

INSERT INTO disciplina (codigo, nome, nucleo, casep, cased, castt, chtap, chtad, chtat, qaead)
VALUES
-- COMUM
('TRI-INI.I.001', 'Língua Portuguesa 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 45.00),
('TRI-INI.I.002', 'Artes', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 45),
('TRI-INI.I.003', 'Educação Física 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 45.00),
('TRI-INI.I.004', 'Matemática 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 45.00),
('TRI-INI.I.005', 'Física - Mecânica', 'Comum', 2.0, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.006', 'Química 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.007', 'Biologia 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.008', 'História 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 45.00),
('TRI-INI.I.009', 'Geografia 1', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.010', 'Filosofia', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.011', 'Língua Estrangeira - Inglês', 'Comum', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
-- DIVERSIFICADO
('TRI-INI.I.012', 'Matemática Aplicada 1', 'Diversificado', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.013', 'Português Instrumental 1', 'Diversificado', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
-- PROFISSIONALIZANTE
('TRI-INI.I.014', 'Fundamentos e Operação de Computadores', 'Profissionalizante', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00),
('TRI-INI.I.015', 'Logica de Programação', 'Profissionalizante', 4.00, 1.00, 5.00, 108.00, 27.00, 135.00, 0.00),
('TRI-INI.I.016', 'Banco de Dados', 'Profissionalizante', 2.00, 0.50, 2.50, 54.00, 13.50, 67.50, 0.00);

-- CURSOS
INSERT INTO curso (nome, campus, periodo)
VALUES
('Informática para Internet', 'Trindade', 'Integral'),
('Edificações', 'Trindade', 'Integral'),
('Controle Ambiental', 'Trindade', 'Matutino');

-- MATRIZ COM ANO E DISCIPLINA
INSERT INTO matriz_ano_disciplina (disciplina_ID, ano)
VALUES 
(1, 1),
--(2, 1), DESCOMENTE PARA ADICIONAR MAIS MATÉRIAS POR ANO
--(3, 1),
--(4, 1),
--(5, 1),
--(6, 1),
--(7, 1),
--(8, 1),
--(1, 2),
--(2, 2),
--(3, 2),
--(9, 2),
--(10, 2),
(15, 2),
(16, 2);

-- MATRIZ
INSERT INTO matriz (curso_ID, matriz_ano_disciplina_ID)
VALUES 
(1, 1), (1, 2), (1, 3);
--(1, 4), (1, 5), (1, 6), DESCOMENTE PARA DISCIPLINAS POR ANO AO CURSO
--(1, 7), (1, 8), (1, 9), 
--(1, 10), (1, 11), (1, 12), 
--(1, 13), (1, 14), (1, 15);


-- SELECTS
-- Todas as disciplinas de uma determinada matriz separadas pelo ano/período:
SELECT mad.ano, d.*
FROM matriz_ano_disciplina mad
JOIN disciplina d ON mad.disciplina_id = d.id
JOIN matriz m ON mad.id = m.matriz_ano_disciplina_id
WHERE m.curso_id = 1; 

-- A carga horaria total por ano/período de uma determinada matriz:
SELECT mad.ano, SUM(d.chtap + d.chtad) AS carga_horaria_total
FROM matriz_ano_disciplina mad
JOIN disciplina d ON mad.disciplina_id = d.id
JOIN matriz m ON mad.id = m.matriz_ano_disciplina_id
WHERE m.curso_id = 1
GROUP BY mad.ano;


-- Todas as disciplinas de todos os núcleos independente do ano/período de uma determinada matriz:
SELECT d.*
FROM disciplina d
JOIN matriz_ano_disciplina mad ON d.id = mad.disciplina_id
JOIN matriz m ON mad.id = m.matriz_ano_disciplina_id
WHERE m.curso_id = 1;


-- Todas as disciplinas do núcleo profissionalizante separados por ano/período de uma determinada matriz:
SELECT mad.ano, d.*
FROM matriz_ano_disciplina mad
JOIN disciplina d ON mad.disciplina_id = d.id
JOIN matriz m ON mad.id = m.matriz_ano_disciplina_id
WHERE m.curso_id = 1 AND d.nucleo = 'Profissionalizante';











