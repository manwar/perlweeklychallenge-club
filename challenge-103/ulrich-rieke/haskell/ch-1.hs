module Challenge103
  where
import Data.List ( (!!) )

animals :: [String]
animals = ["Rat" , "Ox" , "Tiger" , "Rabbit" , "Dragon" , "Snake" ,
      "Horse" , "Goat" , "Monkey" , "Rooster", "Dog" , "Pig"]

elements :: [String]
elements = ["Wood" , "Fire" , "Earth" , "Metal" , "Water"]

solution :: Int -> String
solution year = (elements !! element) ++ " " ++ (animals !! animal)
where
  element :: Int
  element = mod ((year - 1924 ) `div` 2) ( length elements )
  animal :: Int
  animal = mod ( year - 1924 ) ( length animals )
