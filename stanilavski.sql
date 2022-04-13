-- 1. Crear base de datos llamada blog.
CREATE DATABASE blog;
\c blog;

-- 2. Crear las tablas indicadas de acuerdo al modelo de datos.

CREATE TABLE usuario(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    titulo VARCHAR (50),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);

CREATE TABLE  comentario(
    id SERIAL PRIMARY KEY,
    post_id INT,
    usuario_id INT, 
    texto VARCHAR (200), 
    fecha DATE, 
    FOREIGN KEY (post_id) REFERENCES post(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- 3. Insertar los siguientes registros.

INSERT INTO usuario (email) VALUES 
('usuario01@hotmail.com'),
('usuario02@gmail.com'),
('usuario03@gmail.com'),
('usuario04@hotmail.com'),
('usuario05@gmail.com'),
('usuario06@hotmail.com'),
('usuario07@yahoo.com'),
('usuario08@yahoo.com'),
('usuario09@yahoo.com');

INSERT INTO post (usuario_id, titulo, fecha) VALUES
(1, 'Post 1: Esto es malo', '2020-06-29'),
(5, 'Post 2: Esto es malo', '2020-06-20'),
(1, 'Post 3: Esto es excelente', '2020-05-30'),
(9, 'Post 4: Esto es bueno', '2020-05-09'),
(7, 'Post 5: Esto es bueno', '2020-07-10'),
(5, 'Post 6: Esto es excelente', '2020-07-18'),
(8, 'Post 7: Esto es excelente', '2020-07-07'),
(5, 'Post 8: Esto es excelente', '2020-05-14'),
(2, 'Post 9: Esto es bueno', '2020-05-08'),
(6, 'Post 10: Esto es bueno', '2020-06-02'),
(4, 'Post 11: Esto es bueno', '2020-05-05'),
(9, 'Post 12: Esto es malo', '2020-07-23'),
(5, 'Post 13: Esto es excelente', '2020-05-30'),
(8, 'Post 14: Esto es excelente', '2020-05-01'),
(7, 'Post 15: Esto es malo', '2020-06-17');


INSERT INTO comentario (usuario_id, post_id, texto, fecha)
VALUES
(3, 6, 'Este es el comentario 1' ,'2020-07-08'),
(4, 2, 'Este es el comentario 2' ,'2020-06-07'),
(6, 4, 'Este es el comentario 3' ,'2020-06-16'),
(2, 13, 'Este es el comentario 4' ,'2020-06-15'),
(6, 6, 'Este es el comentario 5' ,'2020-05-14'),
(3, 3, 'Este es el comentario 6' ,'2020-07-08'),
(6, 1, 'Este es el comentario 7' ,'2020-05-22'),
(6, 7, 'Este es el comentario 8' ,'2020-07-09'),
(8, 13, 'Este es el comentario 9' ,'2020-06-30'),
(8, 6, 'Este es el comentario 10' ,'2020-06-19'),
(5, 1, 'Este es el comentario 11' ,'2020-05-09'),
(8, 15, 'Este es el comentario 12' ,'2020-06-17'),
(1, 9, 'Este es el comentario 13' ,'2020-05-01'),
(2, 5, 'Este es el comentario 14' ,'2020-05-31'),
(4, 3, 'Este es el comentario 15' ,'2020-06-28');


-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT u.id, u.email, p.titulo 
FROM usuario u
JOIN post p ON u.id=p.usuario_id
WHERE u.id=5;

-- 5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT u.id, u.email, c.texto
FROM usuario u
JOIN comentario c ON u.id=c.usuario_id
WHERE u.email <> 'usuario06@hotmail.com';



-- 6. Listar los usuarios que no han publicado ningún post.

-- Solución 1
SELECT u.id, u.email
FROM usuario u
LEFT JOIN post p ON u.id=p.usuario_id
WHERE p.titulo IS NULL;

-- Solución 2
SELECT u.id, u.email
FROM usuario u
WHERE u.id NOT IN (SELECT usuario_id FROM post);

-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT p.titulo, c.texto
FROM post p
LEFT JOIN comentario c ON p.id=c.post_id;

-- 8. Listar todos los usuarios que hayan publicado un post en Junio.

-- SOLUCIÓN 1
SELECT u.id, u.email, p.fecha
FROM usuario u
JOIN post p ON u.id=p.usuario_id
WHERE EXTRACT(MONTH FROM p.fecha) = 6
ORDER BY p.fecha ASC;

-- SOLUCIÓN 2
SELECT u.id, u.email, p.fecha
FROM usuario u
JOIN post p ON u.id=p.usuario_id
WHERE p.fecha BETWEEN '2020-06-01' AND '2020-06-30'
ORDER BY p.fecha ASC;

-- SOLUCIÓN 3
SELECT u.id, u.email, p.fecha
FROM usuario u
JOIN post p ON u.id=p.usuario_id
WHERE p.fecha >= '2020-06-01' AND p.fecha <='2020-06-30'
ORDER BY p.fecha ASC;
