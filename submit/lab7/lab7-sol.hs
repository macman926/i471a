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
--fnFirst2 :: [a] -> (a -> a -> b) -> (a -> a -> b) -> b

