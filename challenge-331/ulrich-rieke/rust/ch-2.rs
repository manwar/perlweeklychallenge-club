use std::io ;
use std::collections::HashSet ;

fn is_swapped( pair : &[(char , char)]) -> bool {
   let first = pair[0] ;
   let second = pair[1] ;
   first.0 == second.1 && first.1 == second.0
}

//same number of characters
fn condition_1( words : &Vec<&str> ) -> bool {
   words[0].chars( ).count( ) == words[1].chars( ).count( ) 
}

//same characters
fn condition_2( words : &Vec<&str> ) -> bool {
   let mut first_letters = HashSet::new( ) ;
   let mut second_letters = HashSet::new( ) ;
   let first_word = words[0] ;
   let second_word = words[1] ;
   for c in first_word.chars( ) {
      first_letters.insert( c ) ;
   }
   for c in second_word.chars( ) {
      second_letters.insert( c ) ;
   }
   first_letters == second_letters 
}

fn main() {
    println!("Enter two strings separated by a space!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    if condition_1( &words ) && condition_2( &words ) {
       let first_word = words[0] ;
       let second_word = words[1] ;
       let pairs : Vec<(char , char)> = first_word.chars( )
	  .zip( second_word.chars( ) ).collect( ) ;
       let pair_slice = pairs.as_slice( ) ;
       let neighbour_pairs : Vec<&[(char,char)]> = pair_slice.windows( 2 )
	  .collect( ) ;
       if neighbour_pairs.into_iter( ).filter( |&v| is_swapped( v )).count( )
	  == 1 {
	     println!("true") ;
	}
       else {
	  println!("false") ;
       }
    }
    else {
       println!("false") ;
    }
}
