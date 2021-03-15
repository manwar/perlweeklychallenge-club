#!/usr/bin/env runghc

-- run <script>

import Data.List ((\\),)
import Data.List.Extra (maximumOn,)
import Data.List.Utils (join,)

maxChainsAt :: Eq a => (a -> a -> Bool) -> [a] -> a -> [[a]]
maxChainsAt pred xs x
  |notElem x xs =[[]]
  |null validNexts =[[x]]
  |otherwise = concat $ map (\y-> map (x:) $ maxChainsAt pred nxs y) $ validNexts where
     nxs = xs \\ [x]
     validNexts = filter (pred x) nxs

maxChains :: Eq a => (a -> a -> Bool) -> [a] -> [[a]]
maxChains pred xs = concat $ map (maxChainsAt pred xs) xs

areChainable :: Eq a => [a] -> [a] -> Bool
areChainable x y = (last x) == (head y)

main = do
  putStrLn $ join " -> " $ maximumOn length $ maxChains areChainable wrds where
    wrds = words "audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask"
