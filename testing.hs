import Test.HUnit
import Solucion

main = runTestTT tests

tests = test [ejercicio1, ejercicio2, ejercicio3, ejercicio4, ejercicio5, ejercicio6, ejercicio7, ejercicio8, ejercicio9, ejercicio10]

-- Ejercicio 1
ejercicio1 = [
    "Red sin usuarios" ~: (nombresDeUsuarios red1a) ~?= [],
    "Red con un usuario" ~: (nombresDeUsuarios red1b) ~?= ["Martin"],
    "Red con mas de un usuario" ~: (nombresDeUsuarios red1c) ~?= ["Martin", "Ian", "Charly", "Nico"],
    "Red con mas de un usuario con el mismo nombre" ~: (nombresDeUsuarios red1d) ~?= ["Martin"]
    ]

red1a = ([], [], [])
red1b = ([usuario1], [], [])
red1c = ([usuario1, usuario2, usuario3, usuario4], [], [])
red1d = ([usuario1, usuario13], [], [])


-- Ejercicio 2
ejercicio2 = [
    "Un amigo y los demas no tienen amigos" ~:(amigosDe red3a usuario1) ~?= [usuario2],
    "Mas de un amigo y los demas no tienen amigos" ~:(amigosDe red3b usuario1) ~?= [usuario2, usuario3],
    "Cero amigos y los demas no tienen amigos" ~:(amigosDe red3c usuario1) ~?= [],
    "Un amigo y otra persona tiene amigos" ~:(amigosDe red3d usuario1) ~?= [usuario2],
    "Mas de un amigo y otra persona tiene amigos" ~:(amigosDe red3e usuario1) ~?= [usuario2, usuario3],
    "Cero amigos y otra persona tiene amigos" ~:(amigosDe red3f usuario1) ~?= []
    ]

red2a = ([usuario1,usuario2,usuario3,usuario4],[relacion12],[])
red2b = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion13],[])
red2c = ([usuario1,usuario2,usuario3,usuario4],[],[])
red2d = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion24,relacion34],[])
red2e = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion13,relacion24,relacion34],[])
red2f = ([usuario1,usuario2,usuario3,usuario4],[relacion24,relacion34],[])

-- Ejercicio 3
ejercicio3 = [
    "Un amigo y los demas no tienen amigos" ~:(cantidadDeAmigos red3a usuario1) ~?= 1,
    "Mas de un amigo y los demas no tienen amigos" ~:(cantidadDeAmigos red3b usuario1) ~?= 2,
    "Cero amigos y los demas no tienen amigos" ~:(cantidadDeAmigos red3c usuario1) ~?= 0,
    "Un amigo y otra persona tiene amigos" ~:(cantidadDeAmigos red3d usuario1) ~?= 1,
    "Mas de un amigo y otra persona tiene amigos" ~:(cantidadDeAmigos red3e usuario1) ~?= 2,
    "Cero amigos y otra persona tiene amigos" ~:(cantidadDeAmigos red3f usuario1) ~?= 0
    ]

red3a = ([usuario1,usuario2,usuario3,usuario4],[relacion12],[])
red3b = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion13],[])
red3c = ([usuario1,usuario2,usuario3,usuario4],[],[])
red3d = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion24,relacion34],[])
red3e = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion13,relacion24,relacion34],[])
red3f = ([usuario1,usuario2,usuario3,usuario4],[relacion24,relacion34],[])

-- Ejercicio 4
ejercicio4 = [
    "Red con un único usuario sin amigos" ~: (usuarioConMasAmigos red4a) ~?= usuario1, 
    "Red con mas de un usuario sin relaciones" ~: (usuarioConMasAmigos red4b) ~?= usuario3, 
    "Red con mas de un usuario donde uno tiene más amigos que el resto" ~: (usuarioConMasAmigos red4c) ~?= usuario1, 
    "Red de mas de un usuario donde todos tienen la misma cantidad de amigos" ~: (usuarioConMasAmigos red4d) ~?= usuario4
    ]

red4a = ([usuario1], [], [])
red4b = ([usuario1, usuario2, usuario3], [], [])
red4c = ([usuario1, usuario2, usuario3], [relacion12, relacion13], [])
red4d = ([usuario1, usuario2, usuario3, usuario4], [relacion12, relacion34], [])

-- Ejercicio 5
ejercicio5 = [
    "Red con 0 usuarios" ~: (estaRobertoCarlos red5a) ~?= False, 
    "Red con múltiples usuarios relacionados, ninguno supera los 10 amigos" ~: (estaRobertoCarlos red5b) ~?= False, 
    "Red con múltiples usuarios relacionados, el primero tiene 11 amigos" ~: (estaRobertoCarlos red5c) ~?= True, 
    "Red con múltiples usuarios pero no existen relaciones" ~: (estaRobertoCarlos red5d) ~?= False
    ]

red5a = ([], [], [])
red5b = ([usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10], [relacion12, relacion34, relacion56, relacion78, relacion910], [])
red5c = ([usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12], [relacion12, relacion13, relacion14, relacion15, relacion16, relacion17, relacion18, relacion19, relacion110, relacion111, relacion112], [])
red5d = ([usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10], [], [])

-- Ejercicio 6
ejercicio6 = [
    "Nadie tiene publicaciones" ~:(publicacionesDe red6a usuario1) ~?= [],
    "Un usuario tiene una publicacion y nadie mas tiene publicaciones" ~:(publicacionesDe red6b usuario1) ~?= [publicacion6a],
    "Un usuario tiene mas de una publicacion y nadie mas tiene publicaciones" ~:(publicacionesDe red6c usuario1) ~?= [publicacion6a, publicacion6b],
    "Un usuario tiene una publicacion y otra persona tiene publicaciones" ~:(publicacionesDe red6d usuario1) ~?= [publicacion6a],
    "Un usuario tiene mas de una publicacion y otra persona tiene publicaciones" ~:(publicacionesDe red6e usuario1) ~?= [publicacion6a, publicacion6b]
    ]

red6a = ([usuario1,usuario2,usuario3,usuario4],[],[])
red6b = ([usuario1,usuario2,usuario3,usuario4],[],[publicacion6a])
red6c = ([usuario1,usuario2,usuario3,usuario4],[],[publicacion6a, publicacion6b])
red6d = ([usuario1,usuario2,usuario3,usuario4],[],[publicacion6a, publicacion6c])
red6e = ([usuario1,usuario2,usuario3,usuario4],[],[publicacion6a, publicacion6b, publicacion6c])

--Ejercicio 7
ejercicio7 = [
    "Usuario sin me gustas y no hay publicaciones"  ~: (publicacionesQueLeGustanA red7a usuario1) ~?= [],
    "Usuario sin me gustas y hay publicaciones ajenas" ~: (publicacionesQueLeGustanA red7b usuario1) ~?= [],
    "Usuario sin me gustas y él tiene publicaciones" ~: (publicacionesQueLeGustanA red7c usuario1) ~?= [],
    "Usuario con me gustas a otras personas" ~: (publicacionesQueLeGustanA red7d usuario1) ~?= [publicacion7a, publicacion7b],
    "Usuario con me gustas a publicaciones propias" ~: (publicacionesQueLeGustanA red7e usuario1) ~?= [publicacion7c, publicacion7d],
    "Usuario con me gustas a publicaciones propias y ajenas"  ~: (publicacionesQueLeGustanA red7f usuario1) ~?= [publicacion7c, publicacion7a]
    ]

red7a = ([usuario1, usuario2, usuario3, usuario4], [], [])
red7b = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion7f, publicacion7e])
red7c = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion7f])
red7d = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion7a, publicacion7b, publicacion7e])
red7e = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion7c, publicacion7d, publicacion7e])
red7f = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion7c, publicacion7a, publicacion7e])

-- Ejercicio 8
ejercicio8 = [
    "Likean solo la misma publicacion" ~: (lesGustanLasMismasPublicaciones red8a usuario2 usuario3) ~?= True,
    "Uno no likea ninguna publicacion" ~: (lesGustanLasMismasPublicaciones red8b usuario2 usuario3) ~?= False,
    "Red sin publicaciones" ~: (lesGustanLasMismasPublicaciones red8c usuario2 usuario3) ~?= True,
    "Likean una publicacion distinta" ~: (lesGustanLasMismasPublicaciones red8d usuario2 usuario3) ~?= False,
    "Likean las mismas publicaciones (mas de una)" ~: (lesGustanLasMismasPublicaciones red8e usuario2 usuario3) ~?= True,
    "Los likes de uno estan contenidos en los likes del otro" ~: (lesGustanLasMismasPublicaciones red8f usuario2 usuario3) ~?= False,
    "Red con publicaciones pero sin likes" ~: (lesGustanLasMismasPublicaciones red8g usuario2 usuario3) ~?= True
    ]

red8a = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8c])
red8b = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8a])
red8c = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8e])
red8d = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8a, publicacion8b])
red8e = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8c, publicacion8d])
red8f = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8c, publicacion8b])
red8g = ([usuario1, usuario2, usuario3, usuario4], [], [publicacion8e, publicacion8f])

-- Ejercicio 9
ejercicio9 = [
    "No tiene publicaciones"  ~: (tieneUnSeguidorFiel red9a usuario1) ~?= False,
    "Tiene una publicación que no tiene likes" ~: (tieneUnSeguidorFiel red9b usuario1) ~?= False,
    "Tiene publicaciones y no tiene seguidor fiel" ~: (tieneUnSeguidorFiel red9c usuario1) ~?= False,
    "Tiene una publicación y tiene un seguidor fiel" ~: (tieneUnSeguidorFiel red9d usuario1) ~?= True,
    "Tiene una publicación y más de un seguidores fieles" ~: (tieneUnSeguidorFiel red9e usuario1) ~?= True,
    "Tiene varias publicaciones y tiene un seguidor fiel" ~: (tieneUnSeguidorFiel red9f usuario1) ~?= True,
    "Tiene varias publicaciones y más de un seguidor fiel" ~: (tieneUnSeguidorFiel red9g usuario1) ~?= True
    ]

red9a= ([usuario1, usuario2, usuario3, usuario4], [], [])
red9b= ([usuario1, usuario2, usuario3, usuario4], [], [publicacion9a])
red9c=([usuario1, usuario2, usuario3, usuario4], [], [publicacion9b, publicacion9c])
red9d= ([usuario1, usuario2, usuario3, usuario4], [], [publicacion9d])
red9e= ([usuario1, usuario2, usuario3, usuario4], [], [publicacion9e])
red9f=([usuario1, usuario2, usuario3, usuario4], [], [publicacion9b, publicacion9d])
red9g=([usuario1, usuario2, usuario3, usuario4], [], [publicacion9b, publicacion9f])

--Ejercicio 10
ejercicio10 = [
    "no hay relaciones en la red" ~:(existeSecuenciaDeAmigos red10a usuario1 usuario4) ~?= False,
    "hay una relacion en la red pero los usuarios no son amigos entre si y no hay secuencia de amigos entre ambos usuarios" ~:(existeSecuenciaDeAmigos red10b usuario1 usuario4) ~?= False,
    "hay dos relaciones en la red pero los usuarios no son amigos entre si y no una secuencia de amigos entre ambos usuarios" ~:(existeSecuenciaDeAmigos red10c usuario1 usuario4) ~?= False,
    "hay mas de dos relaciones en la red pero no una secuencia de amigos entre ambos usuarios" ~:(existeSecuenciaDeAmigos red10d usuario1 usuario4) ~?= False,
    "hay una relacion en la red y ambos usuarios son amigos" ~:(existeSecuenciaDeAmigos red10e usuario1 usuario4) ~?= True,
    "hay dos relacion en la red y hay una secuencia de amigos entre ambos usuarios" ~:(existeSecuenciaDeAmigos red10f usuario1 usuario4) ~?= True,
    "hay mas de dos relaciones en la red y hay una secuencia de amigos entre ambos usuarios" ~:(existeSecuenciaDeAmigos red10g  usuario1 usuario4) ~?= True,
    "hay un solo usuario en la red y u1 == u2" ~:(existeSecuenciaDeAmigos red10g  usuario1 usuario1) ~?= False
    ]

red10a = ([usuario1,usuario2,usuario3,usuario4],[],[])
red10b = ([usuario1,usuario2,usuario3,usuario4],[relacion12],[])
red10c = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion13],[])
red10d = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion23,relacion13],[])
red10e = ([usuario1,usuario2,usuario3,usuario4],[relacion14],[])
red10f = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion24],[])
red10g = ([usuario1,usuario2,usuario3,usuario4],[relacion12,relacion23,relacion34],[])
red10h = ([usuario1],[],[])


-- (Parámetros)

-- Usuarios
usuario1 = (1, "Martin")
usuario2 = (2, "Ian")
usuario3 = (3, "Charly")
usuario4 = (4, "Nico")

usuario5 = (5, "Matias")
usuario6 = (6, "Jose")
usuario7 = (7, "Pedro")
usuario8 = (8, "Juan")
usuario9 = (9, "Tomas")
usuario10 = (10, "Mateo")
usuario11 = (11, "Santiago")
usuario12 = (12, "Marcelo")
usuario13 = (13, "Martin")

-- Relaciones
relacion12 = (usuario1,usuario2)
relacion13 = (usuario1,usuario3)
relacion14 = (usuario1,usuario4)
relacion23 = (usuario2,usuario3)
relacion24 = (usuario2,usuario4)
relacion34 = (usuario3,usuario4)

relacion56 = (usuario5, usuario6)
relacion78 = (usuario7, usuario8)
relacion910 = (usuario9, usuario10)
relacion15 = (usuario1, usuario5)
relacion16 = (usuario1, usuario6)
relacion17 = (usuario1, usuario7)
relacion18 = (usuario1, usuario8)
relacion19 = (usuario1, usuario9)
relacion110 = (usuario1, usuario10)
relacion111 = (usuario1, usuario11)
relacion112 = (usuario1, usuario12)

-- Publicaciones
publicacion6a = (usuario1, "publicacion", [])
publicacion6b = (usuario1, "publicacion2", [usuario3])
publicacion6c = (usuario2, "publicacion2", [])

publicacion7a = (usuario2, "publicacion", [usuario1, usuario3])
publicacion7b = (usuario4, "publicacion", [usuario1, usuario3])
publicacion7c = (usuario1, "publicacion", [usuario1, usuario3])
publicacion7d = (usuario1, "publicacion", [usuario1, usuario2])
publicacion7e = (usuario4, "publicacion", [usuario2, usuario3])
publicacion7f = (usuario1, "publicacion", [usuario2, usuario3])

publicacion8a = (usuario1, "publicacion", [usuario2])
publicacion8b = (usuario1, "publicacion2", [usuario3])
publicacion8c = (usuario1, "publicacion3", [usuario2, usuario3])
publicacion8d = (usuario1, "publicacion4", [usuario3, usuario2])
publicacion8e = (usuario1, "publicacion5", [])
publicacion8f = (usuario1, "publicacion6", [])

publicacion9a = (usuario1, "publicacion", [])
publicacion9b = (usuario1, "publicacion", [usuario2, usuario4])
publicacion9c = (usuario1, "publicacion", [usuario3])
publicacion9d = (usuario1, "publicacion", [usuario2])
publicacion9e = (usuario1, "publicacion", [usuario2, usuario3])
publicacion9f = (usuario1, "publicacion2", [usuario2, usuario4])
