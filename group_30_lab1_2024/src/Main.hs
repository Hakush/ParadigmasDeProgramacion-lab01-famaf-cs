module Main (main) where

import Dibujos.PruebaG (pruebaGConf)
import Dibujos.Feo (feoConf)
import Dibujos.Grilla (grillaConf)
import Dibujos.Escher (escherConf)
import FloatingPic (Conf (..))
import Interp (initial)
import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)
import Control.Monad (when)

-- Lista de configuraciones de los dibujos 
configs :: [Conf]
configs = [feoConf,pruebaGConf, grillaConf, escherConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
  putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n =
  if n == name c
    then
      initial c 800
    else
      initial' cs n

main :: IO ()
main = do
  args <- getArgs
  when (length args > 2 || null args) $ do
    putStrLn "Sólo puede elegir un dibujo. Para ver los dibujos use -lista ."
    exitFailure
  when (head args == "-lista") $ do
    putStrLn "Los dibujos disponibles son:"
    mapM_ (putStrLn . name) configs
    putStrLn "Ingrese que dibujo desea ver"
    args <- getLine
    when (null args) $ do
      putStrLn "No ingresó un dibujo"
      exitFailure
    when (args `notElem` map name configs) $ do
      putStrLn "No hay un dibujo con ese nombre"
      exitFailure
    when (args `elem` map name configs) $ do
      initial' configs args
      exitSuccess
    exitSuccess
  when (head args == "-a" && not (null $ tail args)) $ do
    --initialH' configsH (args!!1) 
    exitSuccess
  when (head args == "-s" && not (null $ tail args)) $ do
    --initialSVG' configsSVG (args!!1) 
    exitSuccess
  initial' configs $ head args
