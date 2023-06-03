module Solucion where

-- Nombre de Grupo: funcionaPeroNoSeComo
-- Integrante 1: Martin Spiguel
-- Integrante 2: Nicolás Malvicino
-- Integrante 3: Carlos Rafael Chaves López
-- Integrante 4: Ian Colman Lerner

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas
usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejercicios

-- Ejercicio 1
-- Hacemos recursion sobre los usuarios de una red dada y vamos concatenando el nombre de cada uno a una lista
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios ([], _, _) = []
nombresDeUsuarios (u:us, rs, ps) | pertenece (nombreDeUsuario u) (nombresDeUsuarios (us, rs, ps)) = nombresDeUsuarios (us, rs, ps)
                                 | otherwise = nombreDeUsuario u : nombresDeUsuarios (us, rs, ps)

-- Ejercicio 2
-- Hacemos recursion sobre las relaciones de una red dada y vemos si el usuario dado pertenece a cada relacion
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, [], _) u = []
amigosDe (us, r:rs, ps) u | perteneceUsuarioARelacion u r = amigo u r : amigosDe (us, rs, ps) u
                          | otherwise = amigosDe (us, rs, ps) u

-- Devuelve True si solo si un usuario pertenece a una relacion
perteneceUsuarioARelacion :: Usuario -> Relacion -> Bool
perteneceUsuarioARelacion u (a, b) = u == a || u == b

-- Dado un usuario y una relacion devuelve el otro usuario de la relacion
amigo ::  Usuario -> Relacion -> Usuario
amigo u (a, b) | u == a = b
               | u == b = a

-- Ejercicio 3
-- Tomamos la longitud de lo que devuelve la funcion del ejercicio 2
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos (us, rs, ps) u = longitud (amigosDe (us, rs, ps) u)

-- Devuelve el largo de una lista
longitud :: [t] -> Int
longitud [] = 0
longitud (x:xs) = longitud xs + 1

-- Ejercicio 4
-- Hacemos recursion sobre los usuarios de una red dada y comparamos cada usuario con el que tiene mas amigos del resto de los usuarios
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos ([u], _, _) = u
usuarioConMasAmigos (u1:us, rs, ps) | cantidadDeAmigos (u1:us, rs, ps) u1 > cantidadDeAmigos (us, rs, ps) (usuarioConMasAmigos (us, rs, ps)) = u1
                                    | otherwise = usuarioConMasAmigos (us, rs, ps)

-- Ejercicio 5
-- Hacemos recursion sobre los usuarios de una red dada y vemos si alguno tiene mas de 10 amigos
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos ([], _, _) = False
estaRobertoCarlos (u:us, rs, ps) | cantidadDeAmigos (u:us, rs, ps) u > 10 = True
                                 | otherwise = estaRobertoCarlos (us, rs, ps)

-- Ejercicio 6
-- Hacemos recursion sobre las publicaciones de una red dada y vemos si el usuario dado es el que la publico
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) _ = []
publicacionesDe (us, rs, p:ps) u | u == usuarioDePublicacion p = p : publicacionesDe (us, rs, ps) u
                                 | otherwise = publicacionesDe (us, rs, ps) u

-- Ejercicio 7
-- Dado un usuario devuelve una lista de las publicaciones que likeo
-- Hacemos recursion sobre las publicaciones de una red dada y vemos si el usuario dado pertenece a la lista de likes de cada publicacion
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA (_, _, []) _ = []
publicacionesQueLeGustanA (us, rs, p:ps) u | pertenece u (likesDePublicacion p) = p : publicacionesQueLeGustanA (us, rs, ps) u
                                           | otherwise = publicacionesQueLeGustanA (us, rs, ps) u

-- Devuelve True si solo si un elemento pertenece a una lista de esos elementos
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece t (x:xs) | t == x = True
                   | otherwise = pertenece t xs

-- Ejercicio 8
-- Vemos si las publicaciones que les gustan a un usuario dado estan incluidas en las que le gustan a otro usuario dado y viceversa
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red u1 u2 = todosLosElemPertenecen (publicacionesQueLeGustanA red u1) (publicacionesQueLeGustanA red u2)
                                         && todosLosElemPertenecen (publicacionesQueLeGustanA red u2) (publicacionesQueLeGustanA red u1)

-- Devuelve True si solo si todos los elementos de una lista de publicaciones pertenecen a otra lista de publicaciones
todosLosElemPertenecen :: [Publicacion] -> [Publicacion] -> Bool
todosLosElemPertenecen [] _ = True
todosLosElemPertenecen _ [] = False
todosLosElemPertenecen (x:xs) (y:ys) = pertenece x (y:ys) && todosLosElemPertenecen xs (y:ys)

-- Ejercicio 9
-- Hacemos recursion sobre los usuarios de una red dada y nos fijamos si existe algun usuario que likeo todas las publicaciones de un usuario dado
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel ([], _, _) usu = False
tieneUnSeguidorFiel (u:us, rs, ps) usu = esUnSeguidorFiel (u:us, rs, ps) usu u || tieneUnSeguidorFiel (us, rs, ps) usu

-- Devuelve si u2 es un seguidor fiel de u1
esUnSeguidorFiel :: RedSocial -> Usuario -> Usuario -> Bool
esUnSeguidorFiel red u1 u2 = todosLosElemPertenecen (publicacionesDe red u1) (publicacionesQueLeGustanA red u2) && (u1 /= u2)  && longitud (publicacionesDe red u1) > 0

-- Ejercicio 10
-- Nos fijamos si el segundo usuario dado pertenece al "arbol de amigos" del primer usuario dado
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red u1 u2 | u1 == u2 = False
existeSecuenciaDeAmigos red u1 u2 = pertenece u2 (arbolDeAmigos red [u1])

-- Devuelve una lista de todos los usuarios vinculados con un usuario dado mediante una cadena de amigos
-- Crea una lista de los amigos nuevos de los usuarios dados, recursivamente, hasta que no haya amigos nuevos
arbolDeAmigos :: RedSocial -> [Usuario] -> [Usuario]
arbolDeAmigos red us | amigosNuevosDeUsuarios red us == [] = us
                     | otherwise = arbolDeAmigos red (us ++ amigosNuevosDeUsuarios red us)

-- Devuelve una lista de todos los amigos de una lista de usuarios sacandole los que estaban en la lista dada
amigosNuevosDeUsuarios :: RedSocial -> [Usuario] -> [Usuario]
amigosNuevosDeUsuarios _ [] = []
amigosNuevosDeUsuarios red (u:us) = restarListas (amigosDe red u ++ amigosNuevosDeUsuarios red us) (u:us)

-- A la primera lista le saca todos los elementos de la segunda
restarListas :: [Usuario] -> [Usuario] -> [Usuario]
restarListas xs [] = xs
restarListas xs (y:ys) | pertenece y xs = restarListas (quitar y xs) ys
                       | otherwise = restarListas xs ys

-- Elimina todas las apariciones de un elemento en una lista
quitar :: Usuario -> [Usuario] -> [Usuario]
quitar _ [] = []
quitar e (u:us) | u == e = quitar e us
                | otherwise = u : quitar e us