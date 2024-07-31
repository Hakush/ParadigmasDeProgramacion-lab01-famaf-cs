module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP, falla
) where

import Dibujo

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred FigurasBasicas` que devuelve `True` cuando la
-- figura es `Triangulo`.
type Pred a = a -> Bool

-- Ejemplo de una funcion Pred
-- Predicado que devuelve True si la figura es un rectangulo
-- esRectangulo :: Pred FigurasBasicas
-- esRectangulo = (== Rectangulo)

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar p fCambiar dib = change (\x -> if p x then fCambiar x else figura x) dib

-- funcion auxiliar para que foldDib pueda recibir una disyuncion, ignorando los dos floats requeridos
orDib :: Float -> Float -> Bool -> Bool -> Bool
orDib _ _ dib1 dib2 = dib1 || dib2 

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p dib  = foldDib (\x -> p x) id id id orDib orDib (||) dib

-- funcion auxiliar para que foldDib pueda recibir una conjuncion, ignorando los dos floats requeridos
andDib :: Float -> Float -> Bool -> Bool -> Bool
andDib _ _ dib1 dib2 = dib1 && dib2

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib p dib = foldDib (\x -> p x) id id id andDib andDib (&&) dib

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP pred1 pred2 = \x ->  pred1 x && pred2 x

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP pred1 pred2 = \x -> pred1 x || pred2 x

falla :: Bool
falla = False