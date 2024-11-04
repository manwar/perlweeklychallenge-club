use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut for_comparison : Vec<i32> = numbers.clone( ) ;
    for_comparison.sort( ) ;
    let perms : Vec<Vec<i32>> = for_comparison.into_iter( )
       .permutations( numbers.len( ) ).collect() ;
    let len = perms.len( ) ;
    let original : usize = perms.binary_search( &numbers ).unwrap( ) ;
    //if the original number sequence happens to be the last in 
    //lexicographical compare take the first in the list of permutations
    if original == len - 1 {
       println!("{:?}" , perms[0]  ) ;
    }
    else {
       println!("{:?}" , perms[original + 1]) ;
    }
}
