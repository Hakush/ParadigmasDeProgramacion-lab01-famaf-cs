module Dibujos.Escher where

import Dibujo
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blank, color, translate, scale, text, line, pictures )
import Interp(interp, grilla, row, column)

-- Supongamos que eligen.
type Escher = Bool

espacioBlanco :: Dibujo Escher
espacioBlanco = figura False 

interpBasica :: Output Escher
interpBasica True x y w = line $ map (x V.+) [(0,0), y, w, (0,0)]
interpBasica False x y w = blank

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar (encimar p2 (rotar p2)) (encimar (rotar(rotar p2)) (rotar(rotar(rotar p2)))) 
         where
           p2 = espejar (rot45 p)

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar p (encimar p2 p3)
        where 
          p2 = espejar (rot45 p)
          p3 = comp 3 rotar p2

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina n p | n == 1 = cuarteto espacioBlanco espacioBlanco espacioBlanco (dibujoU p)
            | otherwise = cuarteto (esquina (n-1) p) (lado (n-1) p) (rotar(lado (n-1) p)) (dibujoU p)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado n p | n == 1 = cuarteto espacioBlanco espacioBlanco (rotar (dibujoT p)) (dibujoT p)
         | otherwise = cuarteto (lado (n-1) p) (lado (n-1) p) (rotar (dibujoT p)) (dibujoT p)

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = grilla [
                                    [p , q, r ],
                                    [s,  t, u ],
                                    [v,  w, x ]
                                  ]

escher :: Int -> Escher -> Dibujo Escher
escher n p = noneto (esquina n (figura p )) (lado n (figura p)) (r270 (esquina n (figura p))) 
                    (rotar (lado n (figura p))) (dibujoU (figura p)) (r270 (lado n (figura p)))
                    (rotar (esquina n (figura p))) (r180 (lado n (figura p))) (r180 (esquina n (figura p)))

escherConf :: Conf
escherConf = Conf {
          name = "Escher",
          pic =  escher 7 True,
          bas = interpBasica 
}            
