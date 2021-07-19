#!/usr/bin/env -S mira -exec

main = ((++ "\n") . show . frombase2 . modify (1 -) n . tobase2) m
       where
       m = numval ($* ! 1)
       n = numval ($* ! 2) - 1

tobase2 :: num -> [num]
tobase2 = map (mod 2) . takewhile (~= 0) . iterate (div 2)

frombase2 :: [num] -> num
frombase2 = foldl1 ((+) . (2 *)) . reverse

modify :: (* -> *) -> num -> [*] -> [*]
modify op n l = map2 f (index l) l
                where
                f i = op, if i == n
                    = id, otherwise
