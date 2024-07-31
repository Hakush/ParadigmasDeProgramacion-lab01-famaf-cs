module Dibujo (
    Dibujo,
    comp, figura, encimar, apilar, juntar, rotar, rot45, espejar, (^^^), (.-.), (///), r180, r270, encimar4, cuarteto, ciclar, mapDib, change, foldDib
    ) where


-- nuestro lenguaje 
data Dibujo a = Vacio |
                Figura a |  
                Encimar (Dibujo a) (Dibujo a) |   
                Apilar Float Float (Dibujo a) (Dibujo a) |
                Juntar Float Float (Dibujo a) (Dibujo a) |
                Rotar (Dibujo a) |
                Rot45 (Dibujo a) |
                Espejar (Dibujo a)                
                deriving (Eq, Show)

-- combinadores
infixr 6 ^^^

infixr 7 .-.

infixr 8 ///

comp :: Int -> (a -> a) -> a -> a
comp n f dib | n == 0 = dib
             | n >= 1 = comp (n-1) f (f dib)
             | n < 0 = undefined
comp _ _ _ = undefined

-- Funciones constructoras
figura :: a -> Dibujo a
figura fig = Figura fig

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar d1 d2 = Encimar d1 d2

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar f1 f2 d1 d2 = Apilar f1 f2 d1 d2

juntar  :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar f1 f2 d1 d2 = Juntar f1 f2 d1 d2

rotar :: Dibujo a -> Dibujo a
rotar d1 = Rotar d1

rot45 :: Dibujo a -> Dibujo a
rot45 d1 = Rot45 d1

espejar :: Dibujo a -> Dibujo a
espejar d1 = Espejar d1

-- Superpone un dibujo con otro.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = Encimar 

-- Pone el primer dibujo arriba del segundo, ambos ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = Apilar 1 1 

-- Pone un dibujo al lado del otro, ambos ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = Juntar 1 1

-- rotaciones
r180 :: Dibujo a -> Dibujo a
r180 dib = comp 2 rotar dib

r270 :: Dibujo a -> Dibujo a
r270 dib = comp 3 rotar dib 

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 dib = encimar (encimar dib (rotar dib)) (encimar (r180 dib) (r270 dib)) 

-- cuatro figuras en un cuadrante.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto dib1 dib2 dib3 dib4 = (.-.) ((///)dib1 dib2) ((///)dib3 dib4)  

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar dib1 = cuarteto dib1 (rotar dib1) (r180 dib1) (r270 dib1)

-- map para nuestro lenguaje
-- exampleMapFunc :: FigurasBasicas -> FigurasBasicas
-- Correct Example of usage: mapDib exampleMapFunc (Rotar (Figura Triangulo))
-- Correct Example output: Rotar (Figura Rectangulo)
-- Map cambia el tipo original del dibujo por otro, por ejemplo Espejar Triangulo por Espejar Rectangulo
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib _ Vacio = Vacio
mapDib f (Figura a) = figura (f a)
mapDib f (Encimar d1 d2) = Encimar (mapDib f d1) (mapDib f d2)
mapDib f (Apilar f1 f2 d1 d2) = Apilar f1 f2 (mapDib f d1) (mapDib f d2)
mapDib f (Juntar f1 f2 d1 d2) = Juntar f1 f2 (mapDib f d1) (mapDib f d2)
mapDib f (Rotar d1) = Rotar (mapDib f d1)
mapDib f (Rot45 d1) = Rot45 (mapDib f d1)
mapDib f (Espejar d1) = Espejar (mapDib f d1)

-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f

-- Cambiar todas las básicas de acuerdo a la función.
-- exampleChangeFunc :: FigurasBasicas -> Dibujo FigurasBasicas
-- Correct Example of usage: change exampleChangeFunc (Rotar (Figura Triangulo))
-- Correct Example output: Rotar (Rotar (Figura Triangulo))
-- Change cambia el tipo de dibujo por otro, por ejemplo Rotar (Figura Triangulo) por Rotar (Figura Rectangulo)
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change _ Vacio = Vacio
change f (Figura dib) = f dib
change f (Rotar dib)= Rotar (change f dib)
change f (Encimar dib1 dib2) = Encimar (change f dib1) (change f dib2)
change f (Apilar f1 f2 dib1 dib2) = Apilar f1 f2 (change f dib1) (change f dib2)
change f (Juntar f1 f2 dib1 dib2) = Juntar f1 f2 (change f dib1) (change f dib2)
change f (Rot45 dib) = Rot45 (change f dib)
change f (Espejar dib) = Espejar (change f dib)

-- Principio de recursión para Dibujos.
foldDib ::
  (a -> b) -> 
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b
foldDib _ _ _ _ _ _ _ Vacio = undefined

foldDib f _ _ _ _ _ _ (Figura dib) =
  f dib

foldDib f esp rot r45 junt ap enc (Espejar dib) =
  esp (foldDib f esp rot r45 junt ap enc dib)
foldDib f esp rot r45 junt ap enc (Rotar dib) =
  rot (foldDib f esp rot r45 junt ap enc dib)

foldDib f esp rot r45 junt ap enc (Rot45 dib) =
  r45 (foldDib f esp rot r45 junt ap enc dib)
  
foldDib f esp rot r45 junt ap enc (Juntar f1 f2 dib1 dib2) =
   junt f1 f2 (foldDib f esp rot r45 junt ap enc dib1)
                (foldDib f esp rot r45 junt ap enc dib2)

foldDib f esp rot r45 junt ap enc (Apilar f1 f2 dib1 dib2) =
  ap f1 f2 (foldDib f esp rot r45 junt ap enc dib1)
          (foldDib f esp rot r45 junt ap enc dib2)

foldDib f esp rot r45 junt ap enc (Encimar dib1 dib2) =
  enc (foldDib f esp rot r45 junt ap enc dib1) 
          (foldDib f esp rot r45 junt ap enc dib2)
