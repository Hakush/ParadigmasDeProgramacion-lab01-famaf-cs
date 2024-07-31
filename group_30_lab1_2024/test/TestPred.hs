import Test.HUnit
import Pred
import Dibujo

-- Test cambiar function
testCambiar :: Test
testCambiar = TestCase $ do
  let myPred :: Pred Int
      myPred x1 = x1 > 5
      fCambiar :: Int -> Dibujo Int
      fCambiar x2 = figura (x2 + 1)
      dib :: Dibujo Int
      dib = figura 3
      expected = figura 3
     -- putStrLn (show (cambiar pred fCambiar dib))
  assertEqual "cambiar should not modify the dibujo" expected (cambiar myPred fCambiar dib)

-- Test anyDib function
testAnyDib :: Test
testAnyDib = TestCase $ do
  let myPred :: Pred Int
      myPred x = x > 5
      dib :: Dibujo Int
      dib = figura 3 `encimar` figura 7
      expected = True
  assertEqual "anyDib should return True if any element satisfies the predicate" expected (anyDib myPred dib)


-- Test allDib function
testAllDib :: Test
testAllDib = TestCase $ do
  let myPred :: Pred Int
      myPred x = x > 5
      dib :: Dibujo Int
      dib = figura 3 `encimar` figura 7
      expected = False
  assertEqual "allDib should return False if any element does not satisfy the predicate" expected (allDib myPred dib)

-- Test andP function
testAndP :: Test
testAndP = TestCase $ do
  let pred1 :: Pred Int
      pred1 x1 = x1 > 5
      pred2 :: Pred Int
      pred2 x2 = x2 < 10
      myPred :: Pred Int
      myPred = andP pred1 pred2
      x = 7
      expected = True
  assertEqual "andP should return True if both predicates are satisfied" expected (myPred x)

-- Test orP function
testOrP :: Test
testOrP = TestCase $ do
  let pred1 :: Pred Int
      pred1 x1 = x1 > 15
      pred2 :: Pred Int
      pred2 x2 = x2 < 10
      myPred :: Pred Int
      myPred = orP pred1 pred2
      x = 12
      expected = False
  assertEqual "orP should return False if neither predicate is satisfied" expected (myPred x)

-- Test falla constant
testFalla :: Test
testFalla = TestCase $ do
  let expected = False
  assertEqual "falla should always be False" expected falla

-- Test suite
tests :: Test
tests = TestList [testCambiar, testAnyDib, testAllDib, testAndP, testOrP, testFalla]

-- Run the tests

main :: IO Counts
main = runTestTT tests
