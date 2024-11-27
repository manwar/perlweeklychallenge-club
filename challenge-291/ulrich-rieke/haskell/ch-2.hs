module Challenge291_2
   where

select_hands :: Int
select_hands = div (product [48..52] ) ( product [1..5] )

faculty :: Int -> Int
faculty n = product [1..n]

combinations :: Int -> Int -> Int
combinations total selected = div ( faculty total ) ( faculty ( total - selected ) *
 faculty selected ) 

royal_flush :: Int
royal_flush = 4 

straight_runs :: Int
straight_runs = 8

straight_flush :: Int
straight_flush = straight_runs * 4

four_of_a_kind :: Int
four_of_a_kind = 13 * 12 * 4

full_house :: Int
full_house = combinations 4 3 * 13 * combinations 4 2 * 12 

flush :: Int
flush = combinations 13 5 * 4 

straight :: Int
straight = 4 * 8 * 4 * 4 * 4 * 4

three_of_a_kind :: Int
three_of_a_kind = combinations 4 3 * 13 * 4 * 12 * 4 * 11

two_pair :: Int
two_pair = combinations 4 2 * 13 * combinations 4 2 * 12 * 4

pair :: Int
pair = combinations 4 2 * 13 * 12 * 11 * 10 

highcards :: Int
highcards = select_hands - royal_flush - straight_flush - full_house - flush -
 straight - three_of_a_kind - two_pair - pair

main :: IO ( )
main = do
   putStrLn ("select hands: " ++ show select_hands)
   putStrLn ("straight flush: " ++ show straight_flush)
   putStrLn ("flush: " ++ show flush)
   putStrLn ("three of a kind: " ++ show three_of_a_kind)
   putStrLn ("two pair: " ++ show two_pair)
   putStrLn ("pair: " ++ show pair)
   putStrLn ("full house: " ++ show full_house) 
   putStrLn ("straight: " ++ show straight) 
   putStrLn ("straight runs: " ++ show straight_runs) 
   putStrLn ("royal flush: " ++ show royal_flush)
   putStrLn ("high hands: " ++ show highcards) 
