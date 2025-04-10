CREATE TABLE schools(id int, name text 
);

CREATE TABLE courses(id int, name text, price numeric, school_id text
);

CREATE TABLE students(
id int, name text, enrolled_at date, course_id text	
);

INSERT INTO schools (id, name) VALUES
(1, 'Escola da Dona Maria'),
(2, 'Instituto da Dona Maria'),
(3, 'Universidade da Dona Maria'),
(4, 'Academia de Artes da Dona Maria');


INSERT INTO courses (id, name, price, school_id) VALUES
(1, 'Introdução da Dona Maria', 299.99, '1'),
(2, 'Aula da Dona Maria de Matematica', 199.90, '2'),
(3, 'Engenharia caseira da Dona Maria', 450.00, '3'),
(4, 'Aula de História da Maria', 150.00, '4'),
(5, 'Analise da Dona Maria, 300.50, '1'),
(6, 'Aulas de Física da Dona Maria', 320.00, '3'),
(7, 'Aula de Musica da Dona Maria', 120.00, '4'),
(8, 'Data Analyst da Dona Maria', 320.00, '3');


INSERT INTO students (id, name, enrolled_at, course_id) VALUES
(1, 'João Padilha', '2025-03-01', '1'),
(2, 'Maria Padilha', '2025-01-15', '3'),
(3, 'Carlos Padilha', '2025-02-10', '5'),
(4, 'Ana Padilha', '2025-03-22', '4'),
(5, 'Lucas Padilha', '2025-01-30', '2'),
(6, 'Beatriz Padilha', '2025-02-05', '6'),
(7, 'Fernanda Padilha', '2025-02-25', '7'),
(8, 'Ludimar Padilha', '2025-01-12', '8'),
(9, 'Ronaldo Padilha', '2025-02-25', '4');



/*Questão A:*/
SELECT 
    schools.name AS nomeEscola,
    students.enrolled_at AS dataInscricao,
    COUNT(students.id) AS totalEstudante,
    SUM(courses.price) AS valorTotalMaticula
FROM students JOIN 
    courses ON (students.course_id = CAST(courses.id as text)) JOIN 
    schools ON (courses.school_id = CAST(schools.id AS text))
WHERE courses.name not like 'Data%'
GROUP BY nomeEscola, dataInscricao
ORDER BY dataInscricao DESC;

/*Questão B:*/

SELECT 
    schools.name AS nomeEscola,
    students.enrolled_at AS dataInscricao,
    COUNT(students.id) AS totalEstudante,
    SUM(COUNT(students.id)) OVER (PARTITION BY schools.name ORDER BY students.enrolled_at) AS totalAcumulado,
    AVG(COUNT(students.id)) OVER (PARTITION BY schools.name ORDER BY students.enrolled_at ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS media07dias,
    AVG(COUNT(students.id)) OVER (PARTITION BY schools.name ORDER BY students.enrolled_at ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS media30dias
FROM students JOIN 
    courses ON (students.course_id = CAST(courses.id as text)) JOIN 
    schools ON (courses.school_id = CAST(schools.id AS text))
WHERE courses.name not like 'Data%'
GROUP BY nomeEscola, dataInscricao
ORDER BY dataInscricao DESC;


