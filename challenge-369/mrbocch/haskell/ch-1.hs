import Data.Char

-- Data.Aviary.Birds
phenix :: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
phenix f g h x = f (g x) (h x)

validTag :: String -> String
validTag = take 100
             . (:) '#'
             . concat
             . camelCase
             . filter (/= "")
             . map (filter isLetter)
             . words
  where
    capitalize :: String -> String
    capitalize = phenix (:) (toUpper . head) (id . drop 1)

    camelCase :: [String] -> [String]
    camelCase = phenix (:) (map (toLower) . head) (map (capitalize) . drop 1)



main :: IO ()
main = do
  print $ validTag "Cooking with 5 ingredients!"  == "#cookingWithIngredients"
  print $ validTag "the-last-of-the-mohicans"     == "#thelastofthemohicans"
  print $ validTag "  extra spaces here"          == "#extraSpacesHere"
  print $ validTag "iPhone 15 Pro Max Review"     == "#iphoneProMaxReview"
  print $ validTag "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!" == "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
