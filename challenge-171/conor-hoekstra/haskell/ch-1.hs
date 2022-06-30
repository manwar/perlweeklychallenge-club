properDivisors n = init . filter ((0==) . rem n) $ [1..n]
firstNOddAbundant n = take n . filter ((<) <*> sum . properDivisors) $ [1,3..]

firstNOddAbundant 20
-- [945,1575,2205,2835,3465,4095,4725,5355,5775,5985,
--  6435,6615,6825,7245,7425,7875,8085,8415,8505,8925]
