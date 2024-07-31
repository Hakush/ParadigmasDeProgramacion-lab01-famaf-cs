module Dibujos.PruebaG where

import Dibujo
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blank, color, translate, scale, text, line, pictures )
import Interp(interp, grilla, row, column)

type PruebaG = Bool

-- Este archivo fue un intento de explorar la posibilidad de hacer un nuevo dibujo con la 
-- superposisión de grillas de diferentes tamaños.  

espacioBlanco :: Dibujo PruebaG
espacioBlanco = figura False 

interpBasica :: Output PruebaG
interpBasica True x y w = line [x, x V.+ y, x V.+ y V.+ w, x V.+ w, x]
interpBasica False x y w = blank



grilla1 = [map figura [False, False, False]
          ,map figura [False, True,  False]
          ,map figura [False, False, False]]

grilla2 = [map figura [True, True,  True,  True,  True,  True,  True,  True,  True]
          ,map figura [True, True, False, False, False, False, False, True, True]
          ,map figura [True, False, False, False, False, False, False, False, True]
          ,map figura [True, False, False, True, False, True, False, False, True]
          ,map figura [True, False, False, False, True, False, False, False, True]
          ,map figura [True, False, False, True, False, True, False, False, True]
          ,map figura [True, False, False, False, False, False, False, False, True]
          ,map figura [True, True, False, False, False, False, False, True, True]
          ,map figura [True, True,  True,  True,  True,  True,  True,  True,  True]]


grilla3 = [
    map figura [True, False, False, False, False, False, False, False, False, False, False, True]
    ,map figura [False, False, False, False, False, False, False, False, False, False, False, False]
    ,map figura [False, False, True, True, True, True, True, True, True, True, False, False]
    ,map figura [False, False, True, False, False, False, False, False, False, True, False, False]
    ,map figura [False, False, True, False, False, False, False, False, False, True, False, False]
    ,map figura [False, False, True, False, False, True, True, False, False, True, False, False]
    ,map figura [False, False, True, False, False, True, True, False, False, True, False, False]
    ,map figura [False, False, True, False, False, False, False, False, False, True, False, False]
    ,map figura [False, False, True, False, False, False, False, False, False, True, False, False]
    ,map figura [False, False, True, True, True, True, True, True, True, True, False, False]
    ,map figura [False, False, False, False, False, False, False, False, False, False, False, False]
    ,map figura [True, False, False, False, False, False, False, False, False, False, False, True]
    ]


pruebaG :: [[Dibujo PruebaG]] -> [[Dibujo PruebaG]] -> Dibujo PruebaG
pruebaG g1 g2 = encimar (grilla grilla3) (encimar (grilla g1) (grilla g2))

pruebaGConf :: Conf
pruebaGConf = Conf {
          name = "PruebaG",
          pic =  pruebaG grilla1 grilla2,
          bas = interpBasica 
}            