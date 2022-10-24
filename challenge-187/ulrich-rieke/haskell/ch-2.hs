module Challenge187_2
  where
import Data.List ( subsequences , permutations , (!!))
import qualified Data.Set as S
import Data.List.Split( splitOn )

solution :: [Int] -> [[Int]]
solution list = filter myCondition lists_of_three
where
  lists_of_three :: [[Int]]
  lists_of_three = S.toList $ S.fromList  $ concat $ map permutations
  $ filter ( (== 3 ) . length ) $ subsequences list
  max :: Int
  max = maximum $ map sum lists_of_three
  myCondition :: [Int] -> Bool
  myCondition l = ((l !! 0) + (l !! 1 ) > (l !! 2)) &&
  ( (l !! 1) + (l !! 2) > ( l !! 0 ) ) && ((l !! 0 ) + ( l !! 2 )
    > ( l !! 1 )) && ( sum l == max )

finalSolution :: [[Int]] -> [Int]
finalSolution list
  |length list > 1 = concat $ filter (\l -> ((l !! 0) >= (l !! 1)) &&
    ((l !! 1) >= (l !! 2 ))) list
  |otherwise = concat list

main :: IO ( )
main = do
  putStrLn "Please enter some positive numbers separated by a blank!"
  input <- getLine
  let numbers = map read $ splitOn " " input
  print $ finalSolution $ solution numbers
-------------------------------------------------------------------------------
      task 2, in Rust
-------------------------------------------------------------------------------

use std::io ;
use itertools::Itertools ;
use std::collections::HashSet ;

fn main() {
    println!("Please enter at least 3 positive numbers, separated by a blank!") ;
    let mut inputline: String = String::new( ) ;
    io::stdin().read_line( & mut inputline ).unwrap( ) ;
    let entered_line : &str = &*inputline ;
    let mut iter = entered_line.split_whitespace( ) ;
    let mut numbers: Vec<i32> = Vec::new( ) ;
    while let Some( word ) = iter.next( ) {
      numbers.push( word.parse::<i32>().unwrap( )) ;
    }
    let mut the_combis = numbers.into_iter().combinations( 3 ) ;
    let mut all_permus : HashSet<_> = HashSet::new( ) ;
    let mut maximum : i32 = 0 ;
    while let Some( combi ) = the_combis.next( ) {
      for v in  combi.into_iter( ).permutations( 3 ) {
      let sum = v.iter().sum( ) ;
      if sum > maximum {
        maximum = sum ;
      }
      all_permus.insert( v ) ;
      }
    }
    all_permus.retain( | v | {
        v[0] + v[1] > v[2] &&
    v[1] + v[2] > v[0] &&
    v[0] + v[2] > v[1] &&
    v[0] + v[1] + v[2] == maximum
    }) ;
    if all_permus.len( ) > 1 {
      all_permus.retain( | v | v[0] >= v[1] && v[1] >= v[2] ) ;
    }
    println!("{:?}" , all_permus) ;
}
