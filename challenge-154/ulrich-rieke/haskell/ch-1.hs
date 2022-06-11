module Challenge154
  where
import Data.List ( permutations )
import qualified Data.Set as S

firstCombis :: [String]
firstCombis = [ "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE",
      "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE",
      "REPL", "RELP", "RLPE", "RLEP", "LPER", "LPRE", "LEPR",
      "LRPE", "LREP" ]  ;

solution :: [String]
solution = S.toList ((S.fromList $ permutations "PERL") S.\\ ( S.fromList
firstCombis ))
