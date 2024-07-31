import Test.HUnit
import Dibujo

-- Test comp function
testComp :: Test
testComp = TestCase $ do
  let f :: Int -> Int
      f x = x + 1
      n = 3
      dib = 1 
      expected = figura 4
  assertEqual "comp should apply the function n times to the dibujo" expected (figura (comp n f dib))

-- Test figura function
testFigura :: Test
testFigura = TestCase $ do
  let fig = "circle"
      expected = figura "circle"
  assertEqual "figura should create a dibujo with the given figure" expected (figura fig)

-- Test encimar function
testEncimar :: Test
testEncimar = TestCase $ do
  let dib1 = figura "circle"
      dib2 = figura "square"
      expected = encimar (figura "circle") (figura "square")
  assertEqual "encimar should overlay two dibujos" expected (encimar dib1 dib2)

-- Test apilar function
testApilar :: Test
testApilar = TestCase $ do
  let f1 = 0.5
      f2 = 0.5
      dib1 = figura "circle"
      dib2 = figura "square"
      expected = apilar 0.5 0.5 (figura "circle") (figura "square")
  assertEqual "apilar should stack two dibujos vertically" expected (apilar f1 f2 dib1 dib2)

-- Test juntar function
testJuntar :: Test
testJuntar = TestCase $ do
  let f1 = 0.5
      f2 = 0.5
      dib1 = figura "circle"
      dib2 = figura "square"
      expected = juntar 0.5 0.5 (figura "circle") (figura "square")
  assertEqual "juntar should place two dibujos side by side" expected (juntar f1 f2 dib1 dib2)

-- Test rotar function
testRotar :: Test
testRotar = TestCase $ do
  let dib = figura "circle"
      expected = rotar (figura "circle")
  assertEqual "rotar should rotate the dibujo" expected (rotar dib)

-- Test rot45 function
testRot45 :: Test
testRot45 = TestCase $ do
  let dib = figura "circle"
      expected = rot45 (figura "circle")
  assertEqual "rot45 should rotate the dibujo 45 degrees" expected (rot45 dib)

-- Test espejar function
testEspejar :: Test
testEspejar = TestCase $ do
  let dib = figura "circle"
      expected = espejar (figura "circle")
  assertEqual "espejar should mirror the dibujo" expected (espejar dib)

-- Test (^^^) function
testSuperponer :: Test
testSuperponer = TestCase $ do
  let dib1 = figura "circle"
      dib2 = figura "square"
      expected = encimar (figura "circle") (figura "square")
  assertEqual "(^^^) should overlay two dibujos" expected (dib1 ^^^ dib2)

-- Test (.-.) function
testArribaDelOtro :: Test
testArribaDelOtro = TestCase $ do
  let dib1 = figura "circle"
      dib2 = figura "square"
      expected = apilar 1 1 (figura "circle") (figura "square")
  assertEqual "(.-.) should stack two dibujos vertically" expected (dib1 .-. dib2)

-- Test (///) function
testLadoALado :: Test
testLadoALado = TestCase $ do
  let dib1 = figura "circle"
      dib2 = figura "square"
      expected = juntar 1 1 (figura "circle") (figura "square")
  assertEqual "(///) should place two dibujos side by side" expected (dib1 /// dib2)

-- Test r180 function
testR180 :: Test
testR180 = TestCase $ do
  let dib = figura "circle"
      expected = rotar (rotar (figura "circle"))
  assertEqual "r180 should rotate the dibujo 180 degrees" expected (r180 dib)

-- Test r270 function
testR270 :: Test
testR270 = TestCase $ do
  let dib = figura "circle"
      expected = rotar (rotar (rotar (figura "circle")))
  assertEqual "r270 should rotate the dibujo 270 degrees" expected (r270 dib)

-- Test encimar4 function
testEncimar4 :: Test
testEncimar4 = TestCase $ do
  let dib = figura "circle"
      expected = encimar (encimar (figura "circle") (rotar (figura "circle"))) (encimar (rotar (rotar (figura "circle"))) (rotar (rotar (rotar (figura "circle")))))
  assertEqual "encimar4 should overlay the dibujo with its four rotations" expected (encimar4 dib)

-- Test cuarteto function
testCuarteto :: Test
testCuarteto = TestCase $ do
  let dib1 = figura "circle"
      dib2 = figura "square"
      dib3 = figura "triangle"
      dib4 = figura "rectangle"
      expected = apilar 1 1 (juntar 1 1 (figura "circle") (figura "square")) (juntar 1 1 (figura "triangle") (figura "rectangle"))
  assertEqual "cuarteto should create a layout with four dibujos in a quadrant" expected (cuarteto dib1 dib2 dib3 dib4)

-- Test ciclar function
testCiclar :: Test
testCiclar = TestCase $ do
  let dib = figura "circle"
      expected = apilar 1 1 (juntar 1 1 (figura "circle") (rotar (figura "circle"))) (juntar 1 1 (rotar (rotar (figura "circle"))) (rotar (rotar (rotar (figura "circle")))))
  assertEqual "ciclar should create a layout with four copies of the dibujo, each rotated" expected (ciclar dib)

-- Test mapDib function
testMapDib :: Test
testMapDib = TestCase $ do
  let f :: String -> String
      f fig = "red " ++ fig
      dib = figura "circle"
      expected = figura "red circle"
  assertEqual "mapDib should apply the function to the figure of the dibujo" expected (mapDib f dib)

-- Test change function
testChange :: Test
testChange = TestCase $ do
  let f :: String -> Dibujo String
      f fig = figura ("rotated " ++ fig)
      dib = figura "circle"
      expected = figura "rotated circle"
  assertEqual "change should replace the dibujo with the result of applying the function" expected (change f dib)

testFoldDib :: Test
testFoldDib = TestCase $ do
  let f :: String -> String
      f fig = fig
      esp = id
      rot = id
      r45 = id
      junt :: Float -> Float -> String -> String -> String
      junt _ _ x y = x ++ " and " ++ y
      ap = junt
      enc :: String -> String -> String
      enc x y = x ++ " and " ++ y 
      dib1 = figura "circle"
      dib2 = figura "square"
      expected = "circle and square and circle and square"
  assertEqual "foldDib should apply the function to the figures of the dibujos" expected (foldDib f esp rot r45 junt ap enc (encimar  (rotar (dib1)) (apilar 1.0 1.0 (dib2) (juntar 2.0 1.0 (dib1) (dib2)))))

-- Test suite
tests :: Test
tests = TestList [testComp, testFigura, testEncimar, testApilar, testJuntar, testRotar, testRot45, testEspejar, testSuperponer, testArribaDelOtro, testLadoALado, testR180, testR270, testEncimar4, testCuarteto, testCiclar, testMapDib, testChange, testFoldDib]

-- Run the tests
main :: IO Counts 
main = runTestTT tests