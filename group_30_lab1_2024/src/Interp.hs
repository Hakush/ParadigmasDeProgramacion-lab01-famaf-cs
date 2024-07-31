module Interp
  ( interp,
    initial,
    grilla,
    row,
    column,
  )
where

import Dibujo
import FloatingPic
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white, blank, polygon,  Picture)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial (Conf n dib intBas) size = display win white $ withGrid fig size
  where
    win = InWindow n (ceiling size, ceiling size) (0, 0)
    fig = interp intBas dib (0, 0) (size, 0) (0, size)
    desp = -(size / 2)
    withGrid p x = translate desp desp $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 100 100 100 100

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar 1 (fromIntegral $ length ds) d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar 1 (fromIntegral $ length ds) d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

-- Interpretación de (^^^)
ov :: Picture -> Picture -> Picture
ov p q = pictures [p, q]

r45 :: FloatingPic -> FloatingPic
r45 f d w h = f (d V.+ half(w V.+ h)) (half(w V.+ h)) (half(h V.- w))

rot :: FloatingPic -> FloatingPic
rot f d w h = f (d V.+ w) h (V.negate w)

esp :: FloatingPic -> FloatingPic
esp f d w h = f (d V.+ w) (V.negate w) h

-- encimar
sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f1 f2 d w h = pictures [f1 d w h, f2 d w h]

jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun m n f1 f2 d w h = pictures [f1 d w' h, f2 (d V.+ w') (r' V.* w) h]
  where
    r' = n / (m + n)
    r = m / (m + n)
    w' = r V.* w

api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api m n f1 f2 d w h = pictures [f1 (d V.+ h') w (r V.* h), f2 d w h']
  where
    r' = n / (m + n)
    r = m / (m + n)
    h' = r' V.* h

-- Interpretación de Dibujo
interp :: Output a -> Output (Dibujo a)
interp f = foldDib f esp rot r45 jun api sup