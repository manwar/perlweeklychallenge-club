module Knapsack
  where
import Data.List ( subsequences , maximumBy )

itemlist :: [(String, (Int , Int))]
itemlist = [("R", (1 , 1 )) , ("B", (1 , 2 )) , ( "G", (2 , 2 ) ) ,
  ("Y", (12 , 4 ) ) , ("P", (4 , 10 ) ) ]

knapsack :: [(String, (Int , Int))] -> Int -> (String, (Int , Int ))
knapsack items weightlimit =
  let
      collections = subsequences items
      collectionweights = map aggregate collections
      withinlimit = filter (\coll -> (fst $ snd coll) <= weightlimit )
        collectionweights
  in maximumBy myComparator withinlimit

aggregate :: [(String, (Int , Int ))] -> (String, (Int, Int) )
aggregate subitems
  |null subitems = ("", (0 , 0) )
  |(length subitems) == 1 = (fst element ,
    ( fst $ snd element , snd $ snd element ) )
  |(length subitems ) > 1 = foldl1 add subitems
  where
      element = head subitems
      add :: (String , (Int , Int ) ) -> (String , (Int , Int ) ) ->
        (String , (Int , Int ) )
      add itemA itemB = ((fst itemA) ++ (fst itemB) ,
        ((fst $ snd itemA) + ( fst $ snd itemB ) , ( snd $ snd itemA )
          + ( snd $ snd itemB ) ) )

myComparator :: (String , (Int , Int )) -> (String, ( Int, Int )) -> Ordering
myComparator collA collB
  |(snd $ snd collA) < ( snd $ snd collB ) = LT
  |(snd $ snd collA) == ( snd $ snd collB ) = EQ
  |(snd $ snd collA) > ( snd $ snd collB ) = GT

