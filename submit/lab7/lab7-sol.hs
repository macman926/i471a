-- Exercise 1
--function which adds two numbers 
add n1 n2 = n1 + n2
plus = (+)
conc ls1 ls2 = ls1 ++ ls2
add10 = add 10
plus5 = plus 5
concHello = conc "hello"
-- Exercise 2
first (v, _) = v
second (_, v) = v
fst3 (v,_,_) = v
snd3 (_,v,_) = v
thd3 (_,_,v) = v

sumFirst2 :: Num a => [a]-> a
sumFirst2 (a:[]) = a
sumFirst2 (a:b:_) = add a b

fnFirst2 :: [a] -> (a-> a -> b) -> (a -> a -> b) -> b
fnFirst2 (a:b:[]) f1 f2 = f1 a b
fnFirst2 (a:b:rest) f1 f2 = f2 a b

-- Exercise 3
cartesianProduct ls1 ls2 =
 [(x,y) | x <- ls1, y <- ls2]
cartesianProductIf ls1 ls2 predicate =
 [(x,y) | x <- ls1, y <- ls2, predicate x y]

compr1 = [(x,y) | x <- [1 .. 10], y <- [3 * x^2 + 2 * x + 1]]

compr2 = [(x,y) | x <- [1 .. 10], y <- [3 * x^2 + 2 * x + 1], (rem y 3) == 0]

oddEvenPairs a = [(x,y) | x <- [1 .. a], y <- [1 .. a], odd x, even y]

